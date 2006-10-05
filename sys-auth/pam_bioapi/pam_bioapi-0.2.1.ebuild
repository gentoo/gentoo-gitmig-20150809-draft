# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_bioapi/pam_bioapi-0.2.1.ebuild,v 1.1 2006/10/05 13:50:35 wolf31o2 Exp $

inherit flag-o-matic eutils

DESCRIPTION="PAM interface for biometric auth"
HOMEPAGE="http://www.qrivy.net/~michael/blua/"
SRC_URI="http://www.qrivy.net/~michael/blua/pam_bioapi/pam_bioapi-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-auth/bioapi
		sys-auth/tfm-fingerprint"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/pam_bioapi.c-${PV}.patch
}

src_compile() {
	export CPPFLAGS="${CPPFLAGS} -I/opt/bioapi/include"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodir /lib/security
	mv ${D}/usr/lib/security/* ${D}/lib/security
	rmdir ${D}/usr/lib/security
}
