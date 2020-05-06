FROM alpine:3.11

RUN apk update \
	&& apk -U upgrade \
	&& apk add --no-cache ca-certificates \
	&& update-ca-certificates --fresh \
	&& rm -rf /var/cache/apk/*
	
# adds gettyio user and fix gettyio folder's permission
RUN	addgroup gettyio \
	&& adduser -S gettyio -u 1000 -G gettyio

USER gettyio

# for local deployment only
#COPY --chown=gettyio:gettyio .env /

COPY --chown=gettyio:gettyio app /usr/local/bin/
RUN chmod +x /usr/local/bin/app

ENTRYPOINT [ "/usr/local/bin/app" ]
