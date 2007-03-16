# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/yconsole/yconsole-3.0.8.ebuild,v 1.2 2007/03/16 19:01:29 gustavoz Exp $

inherit eutils

DESCRIPTION="monitor and control the Y server"
HOMEPAGE="http://wolfpack.twu.net/YIFF/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*
	media-libs/imlib
	media-libs/yiff"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/3.0.5-makefile-cflags.patch
	epatch "${FILESDIR}"/${P}-gcc33.patch
}

src_compile() {
	cd yconsole
	make OPTFLAGS="${CFLAGS}" || die
}

src_install() {
	cd yconsole
	make install PREFIX="${D}"/usr || die
	dodoc AUTHORS README
}
