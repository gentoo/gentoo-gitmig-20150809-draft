# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_external/mod_auth_external-2.2.3.ebuild,v 1.4 2004/01/15 03:56:36 robbat2 Exp $

inherit eutils

DESCRIPTION="An Apache2 authentication DSO using external programs"
HOMEPAGE="http://www.unixpapa.com/mod_auth_external.html"

S=${WORKDIR}/${P}
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"
DEPEND="sys-libs/pam =net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die; epatch ../${P}-gentoo.diff
}

src_compile() {
	apxs2 -c ${PN}.c || die
	cd pwauth; emake LIB="-lpam -ldl" || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so pwauth/unixgroup pwauth/pwauth
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/10_mod_auth_external.conf
	insinto /etc/pam.d
	newins ${FILESDIR}/pwauth.pam pwauth
	newins ${FILESDIR}/pwauth.pam unixgroup

	dodoc AUTHENTICATORS CHANGES INSTALL INSTALL.HARDCODE README TODO
	docinto mysql; dodoc mysql/*
	docinto pwauth; dodoc pwauth/{FORM_AUTH,INSTALL,README}
	docinto radius; dodoc radius/{CHANGES,README}
	docinto sybase; dodoc sybase/README
	docinto test; dodoc test/*
	dodoc ${FILESDIR}/10_mod_auth_external.conf

	#protect these programs
	local gid=`grep ^apache: /etc/group |cut -d: -f3`
	[ -z "${gid}" ] && gid=81
	fowners root:${gid} /usr/lib/apache2-extramodules/unixgroup
	fowners root:${gid} /usr/lib/apache2-extramodules/pwauth
	fperms 4710 /usr/lib/apache2-extramodules/unixgroup
	fperms 4710 /usr/lib/apache2-extramodules/pwauth
}
