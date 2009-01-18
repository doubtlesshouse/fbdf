all: deb

deb:
	# create all folders
	mkdir -p debian/var/log/bfd
	mkdir -p debian/usr/bin
	mkdir -p debian/etc/bfd/rules-available
	mkdir -p debian/etc/bfd/rules-enabled
	mkdir -p debian/etc/cron.d
	mkdir -p debian/etc/cron.daily
	# copy files to right place
	cp files/rules/* debian/etc/bfd/rules-available
	cp cron debian/etc/cron.d/bfd
	cp cron.daily debian/etc/cron.daily/bfd.daily
	cp CHANGELOG debian/usr/share/doc/bfd/changelog
	cp changelog.Debian debian/usr/share/doc/bfd/
	cp files/alert.bfd debian/etc/bfd/
	cp files/bfd debian/usr/bin/
	cp files/conf.bfd debian/etc/bfd/
	cp files/exclude.files debian/etc/bfd/
	cp files/ignore.hosts debian/etc/bfd/
	# set file permissions
	chmod 0640 debian/etc/bfd/*
	chmod 0740 debian/etc/bfd/rules-available
	chmod 0740 debian/etc/bfd/rules-enabled
	chmod 0640 debian/etc/bfd/rules-available/*
	chmod 0750 debian/etc/cron.d/bfd
	# zipping files
	gzip -9 debian/usr/share/doc/bfd/changelog.Debian
	gzip -9 debian/usr/share/doc/bfd/changelog
	# finally build
	fakeroot dpkg-deb --build debian
	mv debian.deb bfd.deb

clean:
	# clean up debian package build
	-rm -r debian/usr/lib
	-rm -r debian/usr/bin
	-rm -r debian/var
	-rm -r debian/usr/share/doc/bfd/changelo*
	-rm -r debian/etc
	-rm bfd.deb
