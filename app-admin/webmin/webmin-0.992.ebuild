# Copyright 2002, Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webmin/webmin-0.992.ebuild,v 1.3 2002/07/17 20:43:17 drobbins Exp $

DESCRIPTION="Webmin, a web-based system administration interface"
SRC_URI="http://www.webmin.com/download/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.webmin.com/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-devel/perl
	ssl? ( dev-perl/Net-SSLeay )"

src_install() {
	rm -f mount/freebsd-mounts*
	rm -f mount/openbsd-mounts*
	rm -f mount/macos-mounts*
	(find . -name '*.cgi' ; find . -name '*.pl') | perl perlpath.pl /usr/bin/perl -
	mkdir -p ${D}/usr/libexec/webmin
	mkdir -p ${D}/etc/init.d
	mkdir -p ${D}/var
	mkdir -p ${D}/etc/pam.d
	cp -rp * ${D}/usr/libexec/webmin
	cp webmin-gentoo-init ${D}/etc/init.d/webmin
	cp webmin-pam ${D}/etc/pam.d/webmin
	echo gentoo > ${D}/usr/libexec/webmin/install-type
}

pkg_postinst() {
	/etc/init.d/webmin stop >/dev/null 2>&1
	stopstatus=$?
	cd /usr/libexec/webmin
	config_dir=/etc/webmin
	var_dir=/var/webmin
	perl=/usr/bin/perl
	autoos=1
	port=10000
	login=root
	crypt=`grep "^root:" /etc/shadow | cut -f 2 -d :`
	host=`hostname`
	ssl=0
	atboot=0
	nostart=1
	nochown=1
	autothird=1
	nouninstall=1
	noperlpath=1
	export config_dir var_dir perl autoos port login crypt host ssl nochown autothird nouninstall nostart noperlpath
	perl /usr/libexec/webmin/maketemp.pl
	./setup.sh >/tmp/.webmin/webmin-setup.out 2>&1
	cat >/etc/webmin/uninstall.sh <<EOF
#!/bin/sh
printf "Are you sure you want to uninstall Webmin? (y/n) : "
read answer
printf "\\n"
if [ "\\\$answer" = "y" ]; then
        echo "Removing webmin package .."
	/etc/init.d/webmin stop >/dev/null 2>&1
	emerge unmerge webmin
	echo "Done!"
fi
EOF
	chmod +x /etc/webmin/uninstall.sh
	if [ "$stopstatus" = "0" ]; then
		# Start if it was running before
		/etc/init.d/webmin start
	fi
}


