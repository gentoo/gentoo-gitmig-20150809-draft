# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webmin/webmin-1.150-r1.ebuild,v 1.4 2004/07/29 15:47:05 gustavoz Exp $

inherit eutils

IUSE="ssl apache2"

DESCRIPTION="Webmin, a web-based system administration interface"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.webmin.com/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc sparc amd64 ~s390 hppa"

DEPEND=""
RDEPEND="dev-lang/perl
	ssl? ( dev-perl/Net-SSLeay )
	dev-perl/XML-Generator"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Bug #47020
	epatch ${FILESDIR}/${PN}-1.130-webalizer.patch

	# Bug #50810, #51943
	if use apache2; then
		epatch ${FILESDIR}/${PN}-1.140-apache2.patch
	fi
}

src_install() {
	rm -f mount/freebsd-mounts*
	rm -f mount/openbsd-mounts*
	rm -f mount/macos-mounts*
	(find . -name '*.cgi' ; find . -name '*.pl') | perl perlpath.pl /usr/bin/perl -
	dodir /usr/libexec/webmin
	dodir /etc/init.d
	dodir /var
	dodir /etc/pam.d
	cp -rp * ${D}/usr/libexec/webmin
	mv ${D}/usr/libexec/webmin/openslp/config \
		${D}/usr/libexec/webmin/openslp/config-gentoo-linux

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.webmin webmin

	insinto /etc/pam.d/
	newins ${FILESDIR}/webmin-pam webmin
	echo gentoo > ${D}/usr/libexec/webmin/install-type

	exeinto /etc/webmin
	doexe ${FILESDIR}/uninstall.sh
}

pkg_postinst() {
	/etc/init.d/webmin stop >/dev/null 2>&1
	stopstatus=$?
	cd /usr/libexec/webmin
	config_dir=/etc/webmin
	var_dir=/var/log/webmin
	perl=/usr/bin/perl
	autoos=1
	port=10000
	login=root
	crypt=`grep "^root:" /etc/shadow | cut -f 2 -d :`
	host=`hostname`
	use ssl && ssl=1 || ssl=0
	atboot=0
	nostart=1
	nochown=1
	autothird=1
	nouninstall=1
	noperlpath=1
	export config_dir var_dir perl autoos port login crypt host ssl nochown autothird nouninstall nostart noperlpath
	perl /usr/libexec/webmin/maketemp.pl
	./setup.sh >/tmp/.webmin/webmin-setup.out 2>&1

	if [ "$stopstatus" = "0" ]; then
		# Start if it was running before
		/etc/init.d/webmin start
	fi

	sed -i 's:^pidfile=.*$:pidfile=/var/run/webmin.pid:' /etc/webmin/miniserv.conf

	einfo "Add webmin to your boot-time services with 'rc-update add webmin'."
	einfo "Point your web browser to http://localhost:10000 to use webmin."
}

pkg_prerm() {
	/etc/init.d/webmin stop >& /dev/null
}
