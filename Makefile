PROFILE ?= ServerlessCloud-NonProduction-Admin

login:
	aws-sso-util login --profile $(PROFILE)

configure:
	aws-sso-util configure profile $(PROFILE)

init:
	AWS_SDK_LOAD_CONFIG=1 amplify init

serve:
	npm run serve --open