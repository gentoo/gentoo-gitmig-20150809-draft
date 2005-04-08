# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-1.120.ebuild,v 1.1 2005/04/08 21:40:04 eradicator Exp $

IUSE="ssl"

inherit eutils

DESCRIPTION="a web-based user administration interface"
HOMEPAGE="http://www.webmin.com/index6.html"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

DEPEND="dev-lang/perl"

RDEPEND="${DEPEND}
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
	epatch ${FILESDIR}/${PN}-1.100-setup-nocheck.patch
}

src_install() {
	# Change /usr/local/bin/perl references
	find . -type f | xargs sed -i 's:^#!.*/usr/local/bin/perl:#!/usr/bin/perl:'

	dodir /usr/libexec/usermin
	cp -a * ${D}/usr/libexec/usermin

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.usermin usermin

	insinto /etc/pam.d
	newins ${FILESDIR}/${PN}.pam ${PN}

	# Fix ownership
	chown -R root:root ${D}

	dodir /etc/usermin
	dodir /var/log/usermin

	config_dir=${D}/etc/usermin
	var_dir=${D}/var/log/usermin
	perl=${ROOT}/usr/bin/perl
	autoos=1
	port=20000
	login=root
	crypt="XXX"
	host=`hostname`
	use ssl && ssl=1 || ssl=0
	atboot=0
	nostart=1
	nochown=1
	autothird=1
	nouninstall=1
	noperlpath=1
	tempdir="${T}"
	export config_dir var_dir perl autoos port login crypt host ssl nochown autothird nouninstall nostart noperlpath tempdir
	${D}/usr/libexec/usermin/setup.sh > ${T}/usermin-setup.out 2>&1 || die "Failed to create initial usermin configuration."

	# Fixup the config files to use their real locations
	sed -i 's:^pidfile=.*$:pidfile=${ROOT}/var/run/usermin.pid:' ${D}/etc/usermin/miniserv.conf
	find ${D}/etc/usermin -type f -exec sed -i "s:${D}:${ROOT}:g" {} \;

	# Cleanup from the config script
	rm -rf ${D}/var/log/usermin
	keepdir /var/log/usermin/
}

pkg_postinst() {
	local crypt=$(grep "^root:" ${ROOT}/etc/shadow | cut -f 2 -d :)
	dosed "s/root:XXX/root:${crypt}/" /etc/usermin/miniserv.users
	einfo "To make usermin start at boot time, run: 'rc-update add usermin default'."
	einfo "Point your web browser to http://localhost:20000 to use usermin."
}

pkg_prerm() {
	${ROOT}/etc/init.d/usermin stop >& /dev/null
}
