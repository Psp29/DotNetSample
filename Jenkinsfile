pipeline
{
	agent {
		docker {
			image 'mcr.microsoft.com/dotnet/sdk:3.1'
			args '-u root:root -e PATH=$PATH:/root/.dotnet/tools -v /var/run/docker.sock:/var/run/docker.sock'
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
			steps {
    			// withSonarQubeEnv('sonarqube-9.9') {
      				// sh "dotnet ${scannerHome}/SonarScanner.MSBuild.dll begin /k:\"demo-dotnet-app\""
					sh 'docker run --rm -v $PWD:/app -w /app -e SONAR_HOST_URL="https://sonar.prasaddevops.cloud" -e SONAR_LOGIN="sqp_5345a825506219d3e6a76d5557c9e85fe159ee22" sonarsource/sonar-scanner-cli:latest dotnet build && dotnet sonarscanner'
      				sh "dotnet build"
      				// sh "dotnet ${scannerHome}/SonarScanner.MSBuild.dll end"
					sh "dotnet clean"
    			// }
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
