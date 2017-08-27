ansiColor('xterm') {
	withEnv([
		'APP_ID=com.jfintech.loan',
		'APP_NAME=JFintech',
		'CONFIG_ENV=develop',
		'FASTLANE_USER=tanic@anyicorp.com',
		'FASTLANE_PASSWORD=Zz37121024',
		'BILLING_KEY=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgjVTFU+XfaPbDLasXNz/KAwJoVcSYhiBzXnoPSMMVZE68E47Z1cYC7nk53cyFRp94yrKzLAu7X2XcbweOEhPJphTzlClmHuJlUcQSXsupv4L8V4YSmAIKyWkHg6dEe5O5SjFgXm2KbFnRw7NaDl7s7BzaT+LTslnzNsc945SdnR2CGoGFdTiECs8LV51lOQdIm4XR0eHIjUAgLy/zbzog81QlW/yhgsJfw0WD1ePP4s+eCeKPXhXxkKCfuDvr2Wv/uPWKDj85N+4nVFkKf4KXxcLvLVYmVIn/KeR57gJcN6ZmUITUfbXDl2nlCjMHIFErMNtDxmwDu8oIgAFE1/9fwIDAQAB',
		'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/node_modules:./node_modules/.bin:/opt/android-sdk-linux/tools:./platforms/ios/build/device/include/Cordova:/Users/Shared/Jenkins/Library/Android/sdk/tools:/Users/Shared/Jenkins/.rvm/gems/ruby-2.3.0/bin'
		]) {
		node{
			stage('Checkout') { // for display purposes
			  git credentialsId: '86664748-a129-4f47-beff-f5f036d5c7ec', url: 'git@git.play2pay.me:frontend/jmt-ionic.git'
			  sh 'git reset --hard'
			}
			stage('Preparation') {
				sh '''
				    cordova --version
				    #ionic --version
					rm -f *.ipa
					rm -f *.apk
					#rm -rf plugins/*
					chmod +x *.sh
					./compile_global_pre.sh
				'''
			}
			stage('npm+bower+gulp') {
				sh '''
					npm install
					./install_extra_npm.sh
					bower install
					#ionic resources
					gulp
				'''
			}
			stage('Stash platform') {
				stash name: "stash-platform", includes: "*"
			}





			stage('Build Android') {
				def platform = [:]
				platform["Android"] = {
					unstash "stash-platform"
					sh 'gulp config --env production'
					sh 'chmod +x ./*.sh'
					sh './compile_android_1pre.sh'

					withEnv(['MIN_SDK=20','TARGET_SDK=22','MAX_SDK=25']){

						sh './compile_android_2build.sh'
						sh './compile_android_3post.sh'
					}
				}
				parallel platform
			}

			stage('Build Android19') {
				def platform = [:]
				platform["Android"] = {
					unstash "stash-platform"
					sh 'gulp config --env production'
					sh 'chmod +x ./*.sh'
					sh './compile_android_1pre.sh'

					withEnv(['MIN_SDK=19','TARGET_SDK=19','MAX_SDK=19','APP_ID=com.jfintech.loan19']){

						sh './compile_android_2build.sh'
						sh './compile_android_3post.sh'
					}
				}
				parallel platform
			}


			stage('Build IOS') {
				unstash "stash-platform"
				sh 'head fastlane/Appfile'
				sh 'chmod +x ./*.sh'
				sh './compile_ios_1pre.sh'
				sh './compile_ios_2build.sh'
				sh './compile_ios_3post.sh'
			}


		}
	}
}
