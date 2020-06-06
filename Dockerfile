FROM mcr.microsoft.com/mssql/server

USER root

# Create a config directory
RUN mkdir -p /usr/config-sql

WORKDIR /usr/config-sql

# Create config files SQL Server
RUN /bin/echo "/usr/config-sql/import-data.sh & /opt/mssql/bin/sqlservr" > /usr/config-sql/entrypoint.sh && \
/bin/echo -e "# Wait SQL Start\nsleep 30s\n\n# Create BD ProGet\n/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '<put_your_password>' -Q 'CREATE DATABASE [ProGet] COLLATE SQL_Latin1_General_CP1_CI_AS'" > /usr/config-sql/import-data.sh

# Grant permissions for to our scripts to be executable
RUN chmod +x entrypoint.sh import-data.sh

CMD /bin/bash ./entrypoint.sh
