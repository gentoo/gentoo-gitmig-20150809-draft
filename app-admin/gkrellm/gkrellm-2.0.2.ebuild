# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.0.2.ebuild,v 1.3 2002/09/23 17:03:49 doctomoe Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"

DEPEND=">=dev-libs/glib-2.0.4
    >=x11-libs/gtk+-2.0.5"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	if [ ! "`use nls`" ]; then
		cp Makefile Makefile.orig
		sed -e "s:enable_nls=1:enable_nls=0:" Makefile.orig > Makefile
	fi
	
	emake || die
}

src_install () {
	dodir /usr/{bin,include,share/man}
	dodir /usr/lib/gkrellm2/{themes,plugins}

	make install \
		INSTALLDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 \
		INCLUDEDIR=${D}/usr/include \
		LOCALEDIR=${D}/usr/share/locale

	mv gkrellm.1 gkrellm2.1
	
	rm -f ${D}/usr/share/man/man1/*
	doman *.1

	mv src/gkrellm src/gkrellm2
	rm -f ${D}/usr/bin/gkrellm
	dobin src/gkrellm2

	dodoc COPYRIGHT README Changelog
	dohtml *.html
}
