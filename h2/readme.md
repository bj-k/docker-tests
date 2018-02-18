# H2 Image

## Preparation:
- Copy Jar (h2-1.4.195.jar) to this directory.
- Copy any sql file into the sql folder. These will be executed during the FIRST startup.


## Build image:
docker build -t bjk/h2 .


###H2 Commands (internal):
####Start the server:
java -cp h2*.jar org.h2.tools.Server > $H2_LOG

####Stop the server:
java -cp h2*.jar org.h2.tools.Server -tcpShutdown tcp://localhost:1521

####Connect to db:
jdbc:h2:tcp://localhost:1521/test

####Import SQL file:
java -cp h2*.jar org.h2.tools.RunScript -url jdbc:h2:tcp://localhost:1521/test -user sa -script test.sql
