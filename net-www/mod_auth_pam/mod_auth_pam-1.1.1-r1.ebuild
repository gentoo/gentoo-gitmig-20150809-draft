# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_pam/mod_auth_pam-1.1.1-r1.ebuild,v 1.4 2005/02/17 09:30:54 hollow Exp $

inherit eutils apache-module

RESTRICT="nomirror"

DESCRIPTION="PAM authentication module for Apache"
HOMEPAGE="http://pam.sourceforge.net/mod_auth_pam/"

LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
DEPEND="sys-libs/pam"
SLOT="0"
IUSE=""

APACHE2_EXECFILES=".libs/mod_auth_sys_group.so"

APACHE1_MOD_CONF="${PVR}/10_${PN}"
APACHE2_MOD_CONF="${PVR}/10_${PN}"

DOCFILES="INSTALL README doc/*"

need_apache

SRC_URI="apache2?  http://pam.sourceforge.net/mod_auth_pam/dist/${PN}-2.0-${PV}.tar.gz
	 !apache2? http://pam.sourceforge.net/mod_auth_pam/dist/${PN}-${PV}.tar.gz"

use apache2 && S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || "couldn't cd to \$S"
	use apache2 || epatch ${FILESDIR}/${P}-compile-fix.patch || die "patch failed"
	use apache2 && sed -i -e 's/servicename = "httpd"/servicename = "apache2"/' ${PN}.c
	use apache2 || sed -i -e 's/servicename = "httpd"/servicename = "apache"/' ${PN}.c
}

src_compile() {
	apache-module_src_compile
	use apache2 && ${APXS2} -c mod_auth_sys_group.c
}

src_install () {
	apache-module_src_install
	insinto /etc/pam.d
	use apache2 && newins ${FILESDIR}/apache2.pam apache2
	use apache2 || newins ${FILESDIR}/apache2.pam apache
}

pkg_postinst() {
	apache-module_pkg_postinst

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
