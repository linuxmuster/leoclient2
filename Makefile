#!/usr/bin/make
# Zur Erstellung des Debian-Pakets notwendig (make DESTDIR=/root/sophomorix)
# Created by Rüdiger Beck (jeffbeck-at-web.de)
DESTDIR=

# Virtualbox
VBOXDIR=$(DESTDIR)/usr/bin
MENU=$(DESTDIR)/usr/share/menu
# configs
LEOCLIENTCONF=$(DESTDIR)/etc/leoclient2
VIRTCONF=$(DESTDIR)/etc/leovirtstarter2
# Perl modules
PERLMOD=$(DESTDIR)/usr/share/perl5/leoclient2
BIN=$(DESTDIR)/usr/bin
SBIN=$(DESTDIR)/usr/sbin
DESKTOP=$(DESTDIR)/usr/share/applications
ICON=$(DESTDIR)/usr/share/pixmaps
INIT=$(DESTDIR)/etc/init.d

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo '   make leoclient2-leovirtstarter-client'
	@echo '      install virtualbox gui to start machines'
	@echo ' '
	@echo '   make leoclient2-leovirtstarter-server'
	@echo '      install preparation script on server'
	@echo ' '
	@echo '   make leoclient2-leovirtstarter-common'
	@echo '      install common files for leovirtstarter-client and leovirtstarter-server '
	@echo ' '
	@echo '   make leoclient2-vm printer'
	@echo '      install pdf-file splitter and spooler'
	@echo ' '
	@echo '   make deb'
	@echo '      create a debian package'
	@echo ' '
	@echo '   make clean'
	@echo '      clean up stuff created by packaging'
	@echo ' '


default: 
	@echo 'Doing Nothing'


leoclient2-leovirtstarter-client:
	@echo '   * Installing the client script'
	@install -d -m0755 -oroot -groot $(VBOXDIR)
	@install -oroot -groot --mode=0755 gui/leovirtstarter2-client $(VBOXDIR)
	@echo '   * Installing the client configuration files'
	#@install -d -m755 -oroot -groot $(VIRTCONF)
	#@install -oroot -groot --mode=0644 gui/leovirtstarter2.conf $(VIRTCONF)

	@echo '   * Installing unity dash entry'
	@install -d -m0755 -oroot -groot $(DESKTOP)
	@install -oroot -groot --mode=0644 gui/leovirtstarter2-client.desktop $(DESKTOP)
	@echo '   * Installing icon'
	@install -d -m0755 -oroot -groot $(ICON)
	@install -oroot -groot --mode=0644 gui/leovirtstarter2-client.png $(ICON)


leoclient2-leovirtstarter-server:
	@echo '   * Installing the server script'
	@install -d -m0755 -oroot -groot $(VBOXDIR)
	@install -oroot -groot --mode=0755 gui/leovirtstarter2-server $(VBOXDIR)
	@echo '   * Installing the server configuration file'
	@install -d -m755 -oroot -groot $(VIRTCONF)
	@install -oroot -groot --mode=0644 gui/leovirtstarter2-server.conf  $(VIRTCONF)


leoclient2-leovirtstarter-common:
	@echo '   * Installing the common configuration file'
	@install -d -m755 -oroot -groot $(VIRTCONF)
	@install -oroot -groot --mode=0644 gui/leovirtstarter2.conf  $(VIRTCONF)
	@echo '   * Installing the common module'
	@install -d -m755 -oroot -groot $(PERLMOD)
	@install -oroot -groot --mode=0644 gui/leovirtstarter2.pm $(PERLMOD)



# build a package
deb:
	### deb
	dpkg-buildpackage -tc -uc -us -sa -rfakeroot
	@echo ''
	@echo 'Do not forget to tag this version in git. Have you done a dch -i?'
	@echo ''


clean:
	rm -rf  debian/leoclient2


leoclient2-vm-printer:
	@echo '   * Installing printer scripts'
	@install -d -m0755 -oroot -groot $(BIN)
	@install -oroot -groot --mode=0755 printer/run-vm-printer2-splitter $(BIN)
	@install -oroot -groot --mode=0755 printer/run-vm-printer2-spooler $(BIN)
	@install -d -m755 -oroot -groot $(LEOCLIENTCONF)
	@install -oroot -groot --mode=0644 printer/leoclient-vm-printer2.conf  $(LEOCLIENTCONF)
	@install -oroot -groot --mode=0644 conf/machines.conf  $(LEOCLIENTCONF)


