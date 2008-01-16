# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_skey/pam_skey-1.1.4.ebuild,v 1.1 2008/01/16 07:18:25 ulm Exp $

inherit eutils pam

DESCRIPTION="PAM interface for the S/Key authentication system"
HOMEPAGE="http://freshmeat.net/projects/pam_skey/"
SRC_URI="http://dkorunic.net/tarballs/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.78-r3
	>=app-admin/skey-1.1.5-r4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-gentoo.patch"
}

src_compile() {
	econf --libdir="/$(get_libdir)" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README INSTALL
}

pkg_postinst() {
	elog "To use this, you need to add something like"
	elog
	elog "auth       [success=done ignore=ignore auth_err=die default=bad] pam_skey.so"
	elog "auth       sufficient   pam_unix.so likeauth nullok try_first_pass"
	elog
	elog "to an appropriate place in /etc/pam.d/system-auth"
	elog "Consult the documentation for instructions."
}
