#!/bin/bash
function DEBUG()
{
	[ "$_DEBUG" == "on" ] && $@ || :
}

# Display the usage
function DisplayUsage()
{
	echo "Usage:"
	echo "$0 <image list file> <target-registry>"
	echo ""
	echo "Example:"
	echo "$0 image_list.txt hub.fshome.net"
	return 0
}

function RunCmd(){
	if [ "$_DEBUG" == "on" ]
	then 
		echo $@
	else
		$@
	fi
}

function TransferImage()
{
	original_image=$1
	target=$2
	echo "Working on image $original_image ..."
	docker inspect $original_image &> /dev/null
        if [ $? -eq 0 ]
        then
                echo "  Image $original_image already exists, will not pull image."
	else
		#DEBUG echo "  $ docker pull $original_image"
		RunCmd docker pull $original_image
        fi

        target_image=$target$original_image
        # Checks if the target image exists in target registry
        docker inspect $target_image &> /dev/null
        if [ $? -eq 0 ]
	then
                echo "  Image $target_image already exists, will be skipped"
		return 0
        fi
	# DEBUG echo "  $ docker tag $original_image $target_image"
	RunCmd docker tag $original_image $target_image
        # DEBUG echo "  $ docker push $target_image"
	RunCmd docker push $target_image
        # DEBUG echo "  $ docker rmi $original_image $target_image"
	RunCmd docker rmi $original_image $target_image
        echo
}

image_list=$1
target=$2

if [ "$image_list" == "" ]
then
	echo "Missing parameter for image list file"
	DisplayUsage # Call function to display usage
	exit 1 # Return the error code 1 to console
fi

if [ "$target" == "" ]
then
	echo "Missing parameter for target docker registry"
	DisplayUsage
	exit 1 
fi

# Checks if the target variable ends with "/"
# Append the tailling "/" if the target does not end with "/"
echo "$target" | grep '/$'
if [ $? -ne 0 ]
then
	target="$target/"
fi


while read line;
do
	TransferImage $line $target
	# Output a new line
	echo 
done <$image_list


