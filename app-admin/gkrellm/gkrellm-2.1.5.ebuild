# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.1.5.ebuild,v 1.5 2003/02/22 08:56:11 gerk Exp $

DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha ~sparc"
IUSE="gtk gtk2 nls"

DEPEND="gtk? (  >=x11-libs/gtk+-2.0.5 )
	gtk2? ( >=x11-libs/gtk+-2.0.5 )"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	if [ ! "`use nls`" ]; then
		cp Makefile Makefile.orig
		sed -e "s:enable_nls=1:enable_nls=0:" Makefile.orig > Makefile
	fi
	
	if use gtk2 || use gtk
	then
		emake || die
	else
		cd ${S}/server
		emake glib12=1 || die
	fi
}

src_install() {
	dodir /usr/{bin,include,share/man}

	if use gtk2 || use gtk
	then
		keepdir /usr/share/gkrellm2/themes
		keepdir /usr/lib/gkrellm2/plugins

		make install \
			INSTALLDIR=${D}/usr/bin \
			MANDIR=${D}/usr/share/man/man1 \
			INCLUDEDIR=${D}/usr/include \
			LOCALEDIR=${D}/usr/share/locale

		cd ${S}
		mv gkrellm.1 gkrellm2.1
		
		mv src/gkrellm src/gkrellm2
		rm -f ${D}/usr/bin/gkrellm
		dobin src/gkrellm2
	else
		cd ${S}/server
		dobin gkrellmd
		cd ${S}
		rm gkrellm.1
	fi

	rm -f ${D}/usr/share/man/man1/*
	doman *.1

	exeinto /etc/init.d
	doexe ${FILESDIR}/gkrellmd

	dodoc COPYRIGHT README Changelog
	dohtml *.html
}
