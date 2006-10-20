# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-1.230.ebuild,v 1.6 2006/10/20 08:43:34 killerfox Exp $

IUSE="ssl"

inherit eutils pam

DESCRIPTION="a web-based user administration interface"
HOMEPAGE="http://www.webmin.com/index6.html"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 sparc x86"

DEPEND="dev-lang/perl"

RDEPEND="${DEPEND}
	 sys-process/lsof
	 ssl? ( dev-perl/Net-SSLeay )"

#	 pam? ( dev-perl/Authen-PAM )


src_unpack() {
	unpack ${A}

	cd ${S}

	# Point to the correct mysql location
	sed -i -e "s:/usr/local/mysql:/usr:g" mysql/config

	epatch ${FILESDIR}/${PN}-1.080-safestop.patch
	epatch ${FILESDIR}/${PN}-1.150-setup-nocheck.patch
}

src_install() {
	# Change /usr/local/bin/perl references
	find . -type f | xargs sed -i -e 's:^#!.*/usr/local/bin/perl:#!/usr/bin/perl:'

	dodir /usr/libexec/usermin
	cp -pR * ${D}/usr/libexec/usermin

	newinitd ${FILESDIR}/init.d.usermin usermin

	newpamd ${FILESDIR}/${PN}.pam-include ${PN}

	# Fix ownership
	chown -R root:0 ${D}

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
	export config_dir var_dir perl autoos port login crypt host ssl atboot nostart nochown autothird nouninstall noperlpath tempdir
	${D}/usr/libexec/usermin/setup.sh > ${T}/usermin-setup.out 2>&1 || die "Failed to create initial usermin configuration."

	# Fixup the config files to use their real locations
	sed -i -e "s:^pidfile=.*$:pidfile=${ROOT}/var/run/usermin.pid:" ${D}/etc/usermin/miniserv.conf
	find ${D}/etc/usermin -type f | xargs sed -i -e "s:${D}:${ROOT}:g"

	# Cleanup from the config script
	rm -rf ${D}/var/log/usermin
	keepdir /var/log/usermin/
}

pkg_postinst() {
	einfo "To make usermin start at boot time, run: 'rc-update add usermin default'."
	einfo "Point your web browser to http://localhost:20000 to use usermin."
}

pkg_prerm() {
	${ROOT}/etc/init.d/usermin stop >& /dev/null
}
