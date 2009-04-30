# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/yiff/yiff-2.14.5-r1.ebuild,v 1.2 2009/04/30 19:25:39 ranger Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="high performance and stable sound server for UNIX games and apps"
HOMEPAGE="http://wolfpack.twu.net/YIFF/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE="alsa"

DEPEND="alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build-2.patch
	sed -i -e "/^YLIB_DIR/s:/lib:/$(get_libdir):" \
		*/Makefile* || die "sed	failed."
}

src_compile() {
	tc-export CC CXX
	use alsa && append-flags -DALSA_RUN_CONFORM
	emake linux || die "emake failed."
}

src_install() {
	emake PREFIX="${D}"/usr install || die "emake install failed."
	dodoc AUTHORS README
	insinto /etc
	doins yiff/yiffrc || die "doins failed."
}
