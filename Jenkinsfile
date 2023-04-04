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
		stage('Build and Clean the project') {
			steps {
				sh 'dotnet build'
				sh 'dotnet clean'
			}
		}
		stage('Building the code...') {
			steps {
				sh 'dotnet publish -c Release -o out'
			}
		}
	}
	post {
		always {
			archiveArtifacts artifacts: 'out/*', 
			onlyIfSuccessful: true
		}
	}
}
