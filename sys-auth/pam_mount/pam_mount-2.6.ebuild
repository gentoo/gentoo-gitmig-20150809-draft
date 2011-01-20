# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mount/pam_mount-2.6.ebuild,v 1.3 2011/01/20 04:27:53 mattst88 Exp $

EAPI=3

inherit multilib autotools

DESCRIPTION="A PAM module that can mount volumes for a user session"
HOMEPAGE="http://pam-mount.sourceforge.net"
SRC_URI="mirror://sourceforge/pam-mount/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="crypt"
DEPEND=">=sys-libs/pam-0.99
	dev-libs/openssl
	>=sys-libs/libhx-3.6
	dev-libs/libxml2
	>=sys-fs/cryptsetup-1.1.0
	dev-util/pkgconfig
	app-arch/xz-utils"
RDEPEND=">=sys-libs/pam-0.99
	dev-libs/openssl
	>=sys-libs/libhx-3.6
	dev-libs/libxml2
	>=sys-fs/cryptsetup-1.1.0
	sys-process/lsof"

src_prepare() {
	epatch "${FILESDIR}/pam_mount-2.6-pmvarrun-bin.diff"
	eautoreconf
}

src_configure() {
	econf --with-slibdir="/$(get_libdir)" || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/*.txt || die "dodoc failed"
}
