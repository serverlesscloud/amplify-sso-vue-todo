# Amplify Vue Todo


## Profject Initialisation

If you want to use AWS SSO, you need to configure a profile using `aws-sso-util configure` following the instructions here https://github.com/benkehoe/aws-sso-util#configuring-awsconfig

To avoid the AWS SSO issues with `amplify init` described in https://github.com/aws-amplify/amplify-cli/issues/4488, the following must be done:

* Set AWS_SDK_LOAD_CONFIG=1
* Set AWS_Profile={your profile}
* Select the same {your profile} when prompted in amplify init

Followed the instructions to create Vue.js App with AppSync https://docs.amplify.aws/start/getting-started/data-model/q/integration/vue/




## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
