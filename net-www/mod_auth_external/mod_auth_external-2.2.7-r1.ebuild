# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_external/mod_auth_external-2.2.7-r1.ebuild,v 1.1 2005/01/22 04:27:45 trapni Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 authentication DSO using external programs"
HOMEPAGE="http://www.unixpapa.com/mod_auth_external.html"

SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"
DEPEND="sys-libs/pam"
RDEPEND=""
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

DOCFILES="AUTHENTICATORS CHANGES INSTALL INSTALL.HARDCODE README TODO"

APACHE2_MOD_CONF="${PVR}/10_mod_auth_external"
APACHE2_MOD_DEFINE="AUTH_EXTERNAL"
APACHE2_EXECFILES="pwauth/unixgroup pwauth/pwauth"

need_apache2

src_unpack() {
	unpack ${A} || die "unpack ${A} failed"
	cd ${S} || die "cd ${S} failed"
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	apache2_src_compile

	cd pwauth || die "cd pwauth failed"
	sed -i -e  "s,\(LOCALFLAGS=\),\1$CFLAGS ,g" \
		-e  "s,\(LIB=.*\),\1 -lpam -ldl,g" Makefile
	# add `-Wl,-z,now' to LIB to workaround glibc suid/sgid race
	emake LIB="-lpam -ldl -Wl,-z,now" || die "Make failed"
}

src_install() {
	apache2_src_install

	insinto /etc/pam.d
	newins ${FILESDIR}/pwauth.pam pwauth
	newins ${FILESDIR}/pwauth.pam unixgroup

	docinto mysql; dodoc mysql/*
	docinto pwauth; dodoc pwauth/{FORM_AUTH,INSTALL,README}
	docinto radius; dodoc radius/{CHANGES,README}
	docinto sybase; dodoc sybase/README
	docinto test; dodoc test/*

	# protect these programs
	local gid=`grep ^apache: /etc/group |cut -d: -f3`
	[ -z "${gid}" ] && gid=81
	fowners root:${gid} ${APACHE2_MODULESDIR}/unixgroup
	fowners root:${gid} ${APACHE2_MODULESDIR}/pwauth
	fperms 4710 ${APACHE2_MODULESDIR}/unixgroup
	fperms 4710 ${APACHE2_MODULESDIR}/pwauth
}
