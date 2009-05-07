# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mount/pam_mount-1.24.ebuild,v 1.1 2009/05/07 19:25:22 hanno Exp $

inherit multilib

DESCRIPTION="A PAM module that can mount volumes for a user session"
HOMEPAGE="http://pam-mount.sourceforge.net"
SRC_URI="mirror://sourceforge/pam-mount/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="crypt"
DEPEND=">=sys-libs/pam-0.99
	dev-libs/openssl
	>=sys-libs/libhx-2.7
	dev-libs/libxml2
	dev-util/pkgconfig"
RDEPEND=">=sys-libs/pam-0.99
	dev-libs/openssl
	>=sys-libs/libhx-2.7
	dev-libs/libxml2
	>=sys-fs/cryptsetup-1.0.5
	sys-process/lsof"

src_compile() {
	econf --with-slibdir="/$(get_libdir)" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/*.txt || die "dodoc failed"
}
