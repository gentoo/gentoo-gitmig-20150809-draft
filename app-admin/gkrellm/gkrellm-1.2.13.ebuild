# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-1.2.13.ebuild,v 1.7 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1"

RDEPEND="nls? ( sys-devel/gettext )"

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
	dohtml *.html
}
