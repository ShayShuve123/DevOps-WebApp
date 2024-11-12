# DevOps Project – CI/CD Pipeline for Web Application

This project demonstrates a CI/CD pipeline built using Jenkins to automate the deployment, testing, and monitoring of a web application on Apache Tomcat. 
The pipeline includes several Jenkins jobs that sequentially trigger each other to handle tasks such as polling the GitHub repository for updates, deploying changes, checking server uptime, performing automated testing with Selenium, and conducting load and stress tests using Gatling.

## Project Overview

- **Application**: A simple web application deployed on Apache Tomcat with a text input field.
- **CI/CD Pipeline**: Built with Jenkins, consisting of five main jobs.
- **Monitoring**: Server availability monitored using UptimeRobot.
- **Automated Testing**: Functional tests automated with Selenium IDE.
- **Performance Testing**: Load and stress tests conducted using Gatling.

## Pipeline Workflow

The pipeline is structured to poll the GitHub repository every minute, detect changes, and automatically deploy updates. Once an update is deployed, each Jenkins job sequentially triggers the next, initiating server availability monitoring, automated functional tests, and load and stress testing. Below is an overview of each job and its role within the pipeline.

---

### Jobs Descriptions

1. **poll-and-deploy**
   - **Purpose**: This job polls the GitHub repository for changes every minute. If there are changes, it pulls the updated code and deploys it to Apache Tomcat.
   - **Configuration**:
     - **Repository URL**: [https://github.com/ShayShuve123/DevOps_WebApp.git](https://github.com/ShayShuve123/DevOps_WebApp.git)
     - **Trigger**: Poll SCM set to `* * * * *` (every minute).
     - **Build Steps**: Executes shell command to copy files from the `$WORKSPACE` directory to the Tomcat webapps directory.
   - **Shell Command**:
     ```bash
     cp -r $WORKSPACE/* /var/lib/tomcat8/webapps/devops_project
     ```
   - **Outcome**: Ensures that the latest code is always deployed to the web application automatically.

2. **uptime-monitor**
   - **Purpose**: Monitors the availability of the web application using UptimeRobot. Checks server status every five minutes.
   - **Configuration**:
     - **Build Steps**: Uses `curl` to call the UptimeRobot API, verifying the server status.
   - **Shell Command**:
     ```bash
     response=$(curl -s -X POST 'https://api.uptimerobot.com/v2/getMonitors' \
     -d 'api_key=your_api_key&format=json')
     status=$(echo "$response" | jq -r '.monitors[0].status')
     if [ "$status" -eq 2 ]; then
       echo "Server is up."
     else
       exit 1
     fi
     ```
   - **Trigger**: Executes `selenium-test` job only if the server is available.

3. **selenium-test**
   - **Purpose**: Runs automated functional tests on the web application using Selenium IDE. Checks if specific elements and functionalities work as expected.
   - **Configuration**:
     - **Build Steps**: Executes a Selenium `.side` file to simulate user actions.
   - **Shell Command**:
     ```bash
     export NVM_DIR="/home/deftera/.nvm"
     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
     tempfile=$(mktemp) && \
     /home/deftera/.nvm/versions/node/v22.9.0/bin/selenium-side-runner --server http://localhost:4444 -c "browserName=firefox" /home/deftera/devops.side > "$tempfile" && \
     if grep -q "Finished test Test1 Success" "$tempfile"; then
       echo "Test finished successfully.";
     else
       exit 1;
     fi && \
     rm "$tempfile"
     ```
   - **Trigger**: Triggers `gatling-load` job if tests pass successfully.

4. **gatling-load**
   - **Purpose**: Conducts a load test to simulate up to 90% of the system's maximum capacity.
   - **Description**: Gradually increases the number of concurrent users to 90%, maintaining the load for four minutes to observe system behavior. 
   - **Result**: Assesses application performance under expected load conditions.

5. **gatling-stress**
   - **Purpose**: Conducts a stress test by increasing load to 110% of the maximum capacity intermittently.
   - **Description**: Maintains the load at 90% capacity but briefly spikes to 110% three times to assess system resilience.
   - **Result**: Identifies application limits and behavior under unexpected, intense load conditions.

---

## Demonstration

1. **Video 1**: [Pipeline Overview](#)  
   Demonstrates the sequential execution of Jenkins jobs within the pipeline, showing each job being triggered automatically after the previous one completes.

2. **Video 2**: [Code Update and Deployment](#)  
   Demonstrates updating the code locally (changing "Text" to "text"), committing to GitHub, and triggering the CI/CD pipeline. Shows the automatic deployment of the updated text on the web application, as well as the uptime monitoring, automated testing, and load/stress test results.

---

## Screenshots

### Web Application
![Web Application](path/to/your/screenshot.png)

### Jenkins Dashboard
![Jenkins Dashboard](C:\Users\97254\Desktop\Degree\Third year\דאבופס\פרוייקט\images for Readme)

### Gatling Load Test Results
![Gatling Load Test](path/to/gatling_load_test_screenshot.png)

### Gatling Stress Test Results
![Gatling Stress Test](path/to/gatling_stress_test_screenshot.png)

### Uptime Monitoring
![Uptime Monitoring](path/to/uptime_monitor_screenshot.png)

---
