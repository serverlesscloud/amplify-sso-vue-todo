PROFILE ?= ServerlessCloud-NonProduction-Admin

ssoLogin:
	aws-sso-util login --profile $(PROFILE)

ssoConfigure:
	aws-sso-util configure profile $(PROFILE)

init:
	amplify init

serve:
	npm run serve --open