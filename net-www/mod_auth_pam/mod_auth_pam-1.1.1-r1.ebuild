# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pam/mod_auth_pam-1.1.1-r1.ebuild,v 1.3 2005/01/23 13:27:04 trapni Exp $

inherit eutils apache-module

DESCRIPTION="PAM authentication module for Apache2"
HOMEPAGE="http://pam.sourceforge.net/mod_auth_pam/"

SRC_URI="http://pam.sourceforge.net/mod_auth_pam/dist/${PN}-2.0-${PV}.tar.gz"
LICENSE="Apache-1.1"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND="sys-libs/pam"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}"

APACHE2_MOD_CONF="${PVR}/10_mod_auth_pam"
DOCFILES="INSTALL README"

need_apache

src_unpack() {
	unpack "${PN}-2.0-${PV}.tar.gz"
	cd "${S}"
	epatch ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake APXS=${APXS2} || die
}

src_install () {
	APACHE2_MOD_FILE='.libs/mod_auth_sys_group.so' apache2_src_install
	unset DOCFILES APACHE2_MOD_CONF
	APACHE2_MOD_FILE='.libs/mod_auth_pam.so' apache2_src_install

	insinto /etc/pam.d
	newins ${FILESDIR}/apache2.pam apache2

	dohtml doc/*
}

pkg_postinst() {
	local gid=`grep ^shadow: /etc/group | cut -d: -f3`
	einfo
	einfo "If the system is configured with the shadow authentication method"
	einfo "the following commands must be executed by root to make /etc/shadow"
	einfo "accessible by the apache server:"
	einfo
	if [ -z "${gid}" ]; then
		einfo "    # groupadd shadow"
		einfo "    # gpasswd -a apache shadow"
		gid='shadow'
	fi
	einfo "    # chgrp ${gid} /etc/shadow"
	einfo "    # chmod 640 /etc/shadow"
	einfo
}
