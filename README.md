# smk-common-iac
Common Infrastructure as Code for SMK sites.

## Deploying as replicaSet to OpenShift

### in Common Project Space, will be `-toolls` in BCGOV OpenShift Environment

```
 ## following components should be deployed in -tools project space only.
 ## deploy smk-common-iac first
 $ git clone https://github.com/bcgov/smk-common-iac.git
 $ cd smk-common-iac/openshift
 $ oc create -f iac-core.yaml
 ## wait till completion 
 $ oc create -f smk-base.yaml
 ## end of -tools project space components
```

### in Prod/Test/Dev Project Spaces
```
 ## once core and base image creation completed, you can now deploy to -prod or -test project spaces, 
 ## cleanup previous creation
 $ oc project ${YOUR_PROJECT_SPACE}
 $ oc process -f smk-site-deployment-template.yaml \
   SITE_NAME=${SMK_SITENAME} \
   SITE_REPO="${SMK_SITE_GIT_REPO" \
   REPO_BRANCH=${GIT_REPO_BRANCH} WEBHOOK_PATH="${/contextPath}" | oc delete -f -
 ## install after cleanup
 $ oc process -f smk-site-deployment-template.yaml \
   SITE_NAME=${SMK_SITENAME} \
   SITE_REPO="${SMK_SITE_GIT_REPO" \
   REPO_BRANCH=${GIT_REPO_BRANCH} WEBHOOK_PATH="${/contextPath}" | oc delete -f -
 ## for HTTP only site run following  
 $ oc expose svc/smk-${SITE_NAME} --hostname=${YOUR_SITE_FQDN}
 ## for HTTPS only site run following
 $ oc create route edge --service=smk-${SITE_NAME} --hostname=${YOUR_SITE_FQDN}
 ## Optional Steps
 ### get the secrets from secreteMap, and setup github Webhook, 
 ### now you will have auto update from git Repo to running site alive
```
