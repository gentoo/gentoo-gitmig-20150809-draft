# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_chroot/pam_chroot-0.9.2.ebuild,v 1.2 2008/03/21 14:34:13 maekke Exp $

inherit toolchain-funcs pam flag-o-matic eutils

DESCRIPTION="Linux-PAM module that allows a user to be chrooted in auth, account, or session."
HOMEPAGE="http://sourceforge.net/projects/pam-chroot/"
SRC_URI="mirror://sourceforge/pam-chroot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/pam
	!<sys-libs/pam-0.99"
RDEPEND="${DEPEND}"

src_compile() {
	LDFLAGS="$(raw-ldflags)" emake \
		CC="$(tc-getCC)" LD="$(tc-getLD)" || die "emake failed"
}

src_install() {
	dopammod pam_chroot.so
	dopamsecurity  . chroot.conf

	dodoc CREDITS README.history TROUBLESHOOTING options || die "dodoc failed"
}
