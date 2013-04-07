#!/bin/sh

# Filename: pcp.sh
# What: An enhancement to XACML to support filtering of SVG images.
# Why: Final project for INFR 4660U (Web Services and eBusiness Security)
# When: April 7th, 2013
# Author: Daniel Snider
#
# Requirements:
#     Java
#     xml_grep
#     sunxacml.jar
#     samples.jar
#
# Usage:
#     ./pcp.sh [request.xml] [policy.xml] [secured directory]
#     ./pcp.sh request.xml policy.xml ./secure/
#
# Output: The SVG image requested in request.xml that is filtered based on the policy.xml
#
# Limitations: Can only process a single request/action/subject at a time.


if [ "$#" -ne 3 ]
then
        echo "Usage error: Wrong number of arguments."
        echo "Usage: ./pcp.sh [request.xml] [policy.xml] [secured directory]"
        exit 1
fi

if ! [ -d "$3" ]
then
    echo "Error: The secured directory you specified does not exist."
    exit 2
fi

echo "Welcome to the SVG image censorship program based on XACML."
echo "Inputs: $1 $2 $3\n"

resource=`xml_grep --text_only /Request/Resource $1`
subject=`xml_grep --text_only /Request/Subject $1`
action=`xml_grep --text_only /Request/Action $1`

echo "Subject: $subject"
echo "Resource: $resource"
echo "Action: $action\n"

# check if file exists
if ! [ -e "$3$resource" ]
then
    echo "Error: The resource file you specified does not exist."
    exit 3
fi

response=`java -cp "sunxacml.jar:samples.jar" SimplePDP $1 $2`
decision=`echo $response | xml_grep --text_only /Response/Result/Decision`


echo "Policy descision: $decision"

permit="Permit"

if [ $decision = "Permit" ]
then
    cp $3$resource ./
else
    echo "Censorship taking place..."
    sed "/$action/d" $3$resource > ./$resource
fi

echo "Output: ./$resource"