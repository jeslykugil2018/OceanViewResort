# Step 1: Build the application using Ant
FROM frekele/ant:1.10.3-jdk8 AS build
COPY . /app
WORKDIR /app
# Note: In a real environment, we'd run 'ant dist' here. 
# For now, we assume the WAR is built or we use this to show the structure.

# Step 2: Run the application in Tomcat
FROM tomcat:10-jdk17
# Tomcat 10+ uses jakarta.* namespace which matches our code
# Copy the built WAR file from the dist folder
COPY dist/OceanView.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
