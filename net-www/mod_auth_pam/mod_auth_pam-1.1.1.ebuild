# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pam/mod_auth_pam-1.1.1.ebuild,v 1.4 2004/09/03 23:24:08 pvdabeel Exp $

inherit eutils

DESCRIPTION="PAM authentication module for Apache2"
HOMEPAGE="http://pam.sourceforge.net/mod_auth_pam/"

S="${WORKDIR}/${PN}"
SRC_URI="http://pam.sourceforge.net/mod_auth_pam/dist/${PN}-2.0-1.1.1.tar.gz"
LICENSE="Apache-1.1"

KEYWORDS="x86 ppc ~sparc"

DEPEND="sys-libs/pam
	=net-www/apache-2*"
IUSE=""
SLOT="0"

src_unpack() {
	unpack "${PN}-2.0-1.1.1.tar.gz"
	cd "${S}"
	epatch ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake APXS=apxs2 || die
}

src_install () {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/mod_auth_pam.so

	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/10_mod_auth_pam.conf
	insinto /etc/pam.d
	newins ${FILESDIR}/apache2.pam apache2

	dodoc INSTALL README
	dohtml doc/*
}

pkg_postinst() {
	local gid=`grep ^apache: /etc/group |cut -d: -f3`
	[ -z "${gid}" ] && gid=81
	einfo
	einfo "If the system is configured with the shadow authentication method"
	einfo "the following commands must be executed by root to make /etc/shadow"
	einfo "accessible by the apache server:"
	einfo
	einfo "    # chgrp ${gid} /etc/shadow"
	einfo "    # chmod 640 /etc/shadow"
	einfo
}
