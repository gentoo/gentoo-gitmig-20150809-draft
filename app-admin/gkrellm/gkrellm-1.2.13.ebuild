# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-1.2.13.ebuild,v 1.5 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.bz2"
SLOT="0"

KEYWORDS="x86 ppc"
SLOT="1"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1"

RDEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	use nls || ln -sf Makefile.top Makefile
	emake || die
}

src_install () {
	dodir /usr/{bin,include,share/man}
	dodir /usr/share/gkrellm/{themes,plugins}

	make install \
		INSTALLDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 \
		INCLUDEDIR=${D}/usr/include \
		LOCALEDIR=${D}/usr/share/locale

	dodoc COPYRIGHT README Changelog
	dohtml Changelog-plugins.html Changelog-themes.html Themes.html
}


