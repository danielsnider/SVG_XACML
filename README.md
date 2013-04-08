SVG_XACML
=========


Main program filename: pcp.sh

What: An enhancement to XACML to support filtering of SVG images.

Why: Final project for INFR 4660U (Web Services and eBusiness Security)

When: April 7th, 2013

Author: Daniel Snider

##Requirements:
    Java
    xml_grep
    sunxacml.jar
    samples.jar
    

##Usage:
    ./pcp.sh [request.xml] [policy.xml] [secured directory]
    ./pcp.sh request.xml policy.xml ./secure/

Output: The SVG image requested in request.xml that is filtered based on the policy.xml

Limitations: Can only process a single request/action/subject at a time.
