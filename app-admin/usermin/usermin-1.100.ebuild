# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-1.100.ebuild,v 1.7 2005/04/08 10:35:08 corsair Exp $

IUSE="ssl"

inherit eutils

DESCRIPTION="a web-based user administration interface"
HOMEPAGE="http://www.webmin.com/index6.html"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc ppc64 sparc x86 ~hppa"

RDEPEND="dev-lang/perl
	sys-process/lsof
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

	epatch ${FILESDIR}/${PN}-1.080-safestop.patch
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
	${ROOT}/etc/init.d/usermin stop >& /dev/null
	stopstatus=$?

	cd ${ROOT}/usr/libexec/usermin
	config_dir=${ROOT}/etc/usermin
	var_dir=${ROOT}/var/log/usermin
	perl=${ROOT}/usr/bin/perl
	autoos=1
	port=20000
	login=root
	crypt=`grep "^root:" ${ROOT}/etc/shadow | cut -f 2 -d :`
	host=`hostname`
	use ssl && ssl=1 || ssl=0
	atboot=0
	nostart=1
	nochown=1
	autothird=1
	nouninstall=1
	noperlpath=1
	export config_dir var_dir perl autoos port login crypt host ssl nochown autothird nouninstall nostart noperlpath
	perl ${ROOT}/usr/libexec/usermin/maketemp.pl
	./setup.sh > ${ROOT}/tmp/.webmin/usermin-setup.out 2>&1

	if [ "$stopstatus" = "0" ]; then
		# Start if it was running before
		${ROOT}/etc/init.d/usermin start
	fi

	sed -i 's:^pidfile=.*$:pidfile=${ROOT}/var/run/usermin.pid:' ${ROOT}/etc/usermin/miniserv.conf

	einfo "Add usermin to your boot-time services with 'rc-update add usermin'."
	einfo "Point your web browser to http://localhost:20000 to use usermin."
}

pkg_prerm() {
	${ROOT}/etc/init.d/usermin stop >& /dev/null
}
