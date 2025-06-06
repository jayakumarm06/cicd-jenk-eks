##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/devops-java-project
WORKDIR /opt/devops-java-project
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/devops-java-project/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
