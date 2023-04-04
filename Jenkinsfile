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
		// stage('Installing Depedencies...') {
		// 	steps {
		// 		// sh 'cd products_admin'
		// 		sh 'dotnet tool install --global dotnet-ef --version 3.1'
		// 		sh 'export PATH=$PATH:/root/.dotnet/tools'
		// 	}
		// }
		// stage('DB Migration') {
		// 	steps {
		// 		sh 'dotnet-ef database update'
		// 	}
		// }
		stage('Building the code...') {
			steps {
				sh 'dotnet publish -c Release -o out'
				// sh 'cp Users.db out'
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
