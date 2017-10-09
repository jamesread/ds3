create: 
	oc process ds3-web-mysql-on-openshift3 | oc create -f -

install:
	oc delete template ds3-web-mysql-on-openshift3 --ignore-not-found=true
	oc create -f ds3-web-mysql-on-openshift3.yml

delete:
	oc delete all --all

.PHONY: install delete create
