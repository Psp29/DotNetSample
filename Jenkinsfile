pipeline
{
	agent {
		docker {
			image 'mcr.microsoft.com/dotnet/sdk:3.1'
			args '-u root:root -e PATH=$PATH:/root/.dotnet/tools -v /var/run/docker.sock:/var/run/docker.sock '
			} 
	}
	stages {
		// stage('Install Docker') {
      	// 	steps {
        // 		sh 'curl -fsSL https://get.docker.com -o get-docker.sh'
        // 		sh 'sh get-docker.sh'
        // 		// sh 'usermod -aG docker jenkins'
      	// 	}
		// }
		stage('SonarQube Installation') {
			steps {
    			sh 'dotnet tool install --global dotnet-sonarscanner'
				sh 'dotnet tool install --global dotnet-reportgenerator-globaltool'
				sh 'apt-get install openjdk-17-jdk -y'
				sh 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/bin/java'
			}
  		}
		stage('Begin SonarQube Scan') {
			steps {
				sh 'dotnet sonarscanner begin \
					/k:"demo-dotnet-app" \
					/d:sonar.host.url="https://sonar.prasaddevops.cloud" \
					/d:sonar.login="sqp_5345a825506219d3e6a76d5557c9e85fe159ee22"'
			}
		}
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
				sh 'dotnet sonarscanner end /d:sonar.login="sqp_5345a825506219d3e6a76d5557c9e85fe159ee22"'
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
