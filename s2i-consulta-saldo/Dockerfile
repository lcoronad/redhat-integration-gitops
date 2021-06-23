# consulta-saldo-gateway
FROM registry.access.redhat.com/ubi8/openjdk-8

# TODO: Put the maintainer name in the image metadata
LABEL maintainer="Lazaro M Coronado T <lcoronad@redhat.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Microservices consulta saldo" \
      io.k8s.display-name="Consulta Saldo 0.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="Consulta Saldo,0.0.1,SpringBoot"


# Add a volume pointing to /tmp
VOLUME /tmp
# The application's jar file
ARG JAR_FILE=lib/consulta-saldo-0.0.1.jar
# Add the application's jar to the container
ADD ${JAR_FILE} consulta-saldo-0.0.1.jar

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
# CMD ["/usr/libexec/s2i/usage"]
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","consulta-saldo-0.0.1.jar"]
