FROM maven:3.5.3-jdk-8-slim
RUN apt update \
&& apt install -y git gcc g++ make libgfortran3 python python-dev python-setuptools python-pip \
&& apt clean\
&& pip install nose
WORKDIR /home
ADD . /home/
RUN JAVA_FLAGS=-Djdk.net.URLClassPath.disableClassPathURLCheck=true mvn package
RUN cp target/sparkts-0.4.0-SNAPSHOT-jar-with-dependencies.jar python/sparkts/
RUN cd python && python setup.py sdist
