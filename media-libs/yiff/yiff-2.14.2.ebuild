# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/yiff/yiff-2.14.2.ebuild,v 1.3 2004/03/19 07:56:05 mr_bones_ Exp $

inherit flag-o-matic

DESCRIPTION="high performance and stable sound server for UNIX games and apps"
HOMEPAGE="http://wolfpack.twu.net/YIFF/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk mikmod"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	mikmod? ( media-libs/libmikmod )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	local pkgs="libY2 yiff yiffutils"
	[ `use gtk` ] && pkgs="${pkgs} yiffconfig" && append-flags `gtk-config --cflags`
	[ `use mikmod` ] && append-flags -DHAVE_LIBKMID
	append-flags -DALSA_RUN_CONFORM -DOSS -DOSS_BUFFRAG -DYSHM_SUPPORT -D__USE_BSD
	make linux \
		CFLAGS="${CFLAGS}" \
		LINUX_DIRS="${pkgs}" \
		|| die
}

src_install() {
	make install PREFIX=${D}/usr || die
	dodoc AUTHORS README
}
