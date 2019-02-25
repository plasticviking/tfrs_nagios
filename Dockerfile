FROM tfrs_nagios:base
EXPOSE 8080
RUN mkdir /var/run/apache2-supervisord
RUN chown -R nagios.nagios /var/run/apache2-supervisord
RUN mkdir /var/run/supervisord
RUN chown -R nagios.nagios /var/run/supervisord
RUN mkdir /docroot
RUN chown -R nagios.nagios /docroot
WORKDIR /
ADD docroot /docroot
ADD apache2 /etc/apache2
ADD supervisord /etc
# remove the default configuration
RUN rm -fr /etc/nagios3
RUN mkdir /etc/nagios3
ADD nagios3 /etc/nagios3
RUN chown -R nagios.nagios /etc/nagios3
RUN htpasswd -bc /etc/nagios3/htpasswd.users nagiosadmin password
USER nagios
CMD supervisord
