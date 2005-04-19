# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/yiff/yiff-2.14.2.ebuild,v 1.12 2005/04/19 00:18:54 vapier Exp $

inherit flag-o-matic eutils kde

DESCRIPTION="high performance and stable sound server for UNIX games and apps"
HOMEPAGE="http://wolfpack.twu.net/YIFF/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="gtk alsa"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc3.patch
	epatch "${FILESDIR}"/${P}-PIC.patch
	for d in libY2 yiff{,config,utils} ; do
		cd "${S}"/${d}
		epatch "${FILESDIR}"/${P}-gcc33.patch
	done
}

src_compile() {
	local pkgs="libY2 yiff yiffutils"
	use gtk && pkgs="${pkgs} yiffconfig" && append-flags `gtk-config --cflags`
	#append-flags -DHAVE_LIBKMID
	use alsa && append-flags -DALSA_RUN_CONFORM
	append-flags -DOSS -DOSS_BUFFRAG -DYSHM_SUPPORT -D__USE_BSD
	make linux \
		CFLAGS="${CFLAGS}" \
		LINUX_DIRS="${pkgs}" \
		|| die
}

src_install() {
	make install PREFIX="${D}/usr" YLIB_DIR="${D}/usr/$(get_libdir)" || die
	dodoc AUTHORS README
}
