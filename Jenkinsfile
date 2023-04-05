pipeline
{
	agent {
		docker {
			image 'mcr.microsoft.com/dotnet/sdk:3.1'
			args '-u root:root -e PATH=$PATH:/root/.dotnet/tools'
			} 
	}
	stages {
		stage('Restoring') {
			steps {
				sh 'dotnet restore'
			}
		}
		// stage('Build and Clean the project') {
		// 	steps {
		// 		sh 'dotnet build'
		// 		sh 'dotnet clean'
		// 	}
		// }
		stage('SonarQube Analysis') {
    		def scannerHome = tool 'SonarScanner for MSBuild'
    		withSonarQubeEnv() {
      			sh "dotnet ${scannerHome}/SonarScanner.MSBuild.dll begin /k:\"demo-dotnet-app\""
      			sh "dotnet build"
      			sh "dotnet ${scannerHome}/SonarScanner.MSBuild.dll end"
    		}
  		}
		stage('Building the code...') {
			steps {
				sh 'dotnet publish -c Release -o out'
			}
		}
		stage('Deploying the site') {
			steps {
				sh 'nohup dotnet out/MyWebApp.dll > /dev/null 2>&1 &'
			}
		}
	}
	post {
		always {
			// archiveArtifacts artifacts: 'out/*', 
			// onlyIfSuccessful: true
			cleanWs()
		}
	}
}
