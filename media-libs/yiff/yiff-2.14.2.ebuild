# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/yiff/yiff-2.14.2.ebuild,v 1.10 2004/07/14 04:21:16 vapier Exp $

inherit flag-o-matic eutils kde

DESCRIPTION="high performance and stable sound server for UNIX games and apps"
HOMEPAGE="http://wolfpack.twu.net/YIFF/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="gtk alsa"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	!sparc? ( alsa? ( media-libs/alsa-lib ) )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
	epatch ${FILESDIR}/${P}-PIC.patch
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
	make install PREFIX=${D}/usr || die
	dodoc AUTHORS README
}
