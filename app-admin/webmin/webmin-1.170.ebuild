# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webmin/webmin-1.170.ebuild,v 1.2 2004/11/18 05:58:11 eradicator Exp $

IUSE="ssl apache2 webmin-minimal"

inherit eutils

DESCRIPTION="Webmin, a web-based system administration interface"
HOMEPAGE="http://www.webmin.com/"
SRC_URI="webmin-minimal? ( mirror://sourceforge/webadmin/${P}-minimal.tar.gz )
	!webmin-minimal? ( mirror://sourceforge/webadmin/${P}.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~s390 ~sparc ~x86 ~mips"

DEPEND="dev-lang/perl"
RDEPEND="ssl? ( dev-perl/Net-SSLeay )
	dev-perl/XML-Generator"

src_unpack() {
	unpack ${A}

	# in webmin-minimal webalizer and apache2 are not present
	if ! use webmin-minimal ; then
		cd ${S}
		# Bug #47020
		epatch ${FILESDIR}/${PN}-1.130-webalizer.patch

		# Bug #50810, #51943
		if use apache2; then
			epatch ${FILESDIR}/${PN}-1.140-apache2.patch
		fi
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

	# in webmin-minimal openslp is not present
	if [ ! -f "${D}/usr/libexec/webmin/openslp/config-gentoo-linux" ] ; then
		cp ${D}/usr/libexec/webmin/openslp/config \
			${D}/usr/libexec/webmin/openslp/config-gentoo-linux
	fi

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
