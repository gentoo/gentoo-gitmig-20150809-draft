# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_bioapi/pam_bioapi-0.2.1-r1.ebuild,v 1.1 2007/02/26 04:17:17 vapier Exp $

inherit eutils

DESCRIPTION="PAM interface for biometric auth"
HOMEPAGE="http://www.qrivy.net/~michael/blua/"
SRC_URI="http://www.qrivy.net/~michael/blua/pam_bioapi/${P}.tar.bz2
	http://upir.cz/linux/patches/${P}-alter-environ.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-auth/bioapi
	sys-libs/pam
	sys-auth/tfm-fingerprint"

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	epatch "${FILESDIR}"/pam_bioapi.c-${PV}.patch
	epatch "${DISTDIR}"/${P}-alter-environ.patch
}

src_compile() {
	export CPPFLAGS="${CPPFLAGS} -I/opt/bioapi/include"
	econf --prefix=/ || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "einstall failed"
	find "${D}" -name '*.la' -print0 | xargs -0 rm
	dodir /usr
	mv "${D}"/bin "${D}"/usr/bin || die
}
