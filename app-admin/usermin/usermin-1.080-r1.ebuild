# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-1.080-r1.ebuild,v 1.6 2004/07/26 08:34:48 eradicator Exp $

inherit eutils

DESCRIPTION="a web-based user administration interface"
HOMEPAGE="http://www.webmin.com/index6.html"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc amd64"
IUSE="ssl"

RDEPEND="dev-lang/perl
	sys-apps/lsof
	>=sys-apps/sed-4
	dev-perl/Authen-PAM
	ssl? ( dev-perl/Net-SSLeay )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Point to the correct mysql location
	sed -i "s:/usr/local/mysql:/usr:g" mysql/config

	# Bug #46273... missing config for gentoo
	cp quota/generic-linux-lib.pl quota/gentoo-linux-lib.p

	epatch ${FILESDIR}/${P}-safestop.patch
}

src_install() {
	dodir /usr/libexec/usermin
	cp -a * ${D}/usr/libexec/usermin

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.usermin usermin

	insinto /etc/pam.d
	newins ${FILESDIR}/${PN}.pam ${PN}

	dosym ../usr/libexec/usermin /etc/usermin

	# Change /usr/local/bin/perl references
	find ${D} -type f | xargs sed -i 's:^#!.*/usr/local/bin/perl:#!/usr/bin/perl:'
}

pkg_postinst() {
	/etc/init.d/usermin stop >& /dev/null
	stopstatus=$?

	cd /usr/libexec/usermin
	config_dir=/etc/usermin
	var_dir=/var/log/usermin
	perl=/usr/bin/perl
	autoos=1
	port=20000
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
	perl /usr/libexec/usermin/maketemp.pl
	./setup.sh > /tmp/.webmin/usermin-setup.out 2>&1

	if [ "$stopstatus" = "0" ]; then
		# Start if it was running before
		/etc/init.d/usermin start
	fi

	sed -i 's:^pidfile=.*$:pidfile=/var/run/usermin.pid:' /etc/usermin/miniserv.conf

	einfo "Add usermin to your boot-time services with 'rc-update add usermin'."
	einfo "Point your web browser to http://localhost:20000 to use usermin."
}

pkg_prerm() {
	/etc/init.d/usermin stop >& /dev/null
}
