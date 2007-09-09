# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_chroot/pam_chroot-0.9.1.ebuild,v 1.9 2007/09/09 00:08:13 josejx Exp $

inherit toolchain-funcs pam flag-o-matic eutils

DESCRIPTION="Linux-PAM module that allows a user to be chrooted in auth, account, or session."
HOMEPAGE="http://sourceforge.net/projects/pam-chroot/"
SRC_URI="mirror://sourceforge/pam-chroot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/pam
	!<sys-libs/pam-0.99"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-gcc42.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getLD)" \
		LDFLAGS="$(raw-ldflags)" || die "emake failed"
}

src_install() {
	dopammod pam_chroot.so
	dopamsecurity  . chroot.conf

	dodoc CREDITS TROUBLESHOOTING options || die "dodoc failed"
}
