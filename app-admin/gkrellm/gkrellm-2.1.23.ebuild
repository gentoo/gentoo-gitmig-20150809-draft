# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.1.23.ebuild,v 1.4 2004/01/20 20:04:18 spock Exp $

IUSE="gtk gtk2 nls"

S=${WORKDIR}/${P/a/}
DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/gkrellm/${P}.tar.bz2"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~alpha sparc ~hppa"

DEPEND=">=sys-apps/sed-4
	gtk? (  >=x11-libs/gtk+-2.0.5 )
	gtk2? ( >=x11-libs/gtk+-2.0.5 )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	if [ ! "`use nls`" ]; then
		sed -i "s:enable_nls=1:enable_nls=0:" Makefile
	fi

	sed -i 's:INSTALLROOT ?= /usr/local:INSTALLROOT ?= ${D}/usr:' Makefile

	if use gtk2 || use gtk
	then
		PREFIX=/usr emake || die
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

		make DESTDIR=${D} install \
			INSTALLDIR=${D}/usr/bin \
			MANDIR=${D}/usr/share/man/man1 \
			INCLUDEDIR=${D}/usr/include \
			LOCALEDIR=${D}/usr/share/locale \
			PKGCONFIGDIR=${D}/usr/lib/pkgconfig

		cd ${S}
		mv gkrellm.1 gkrellm2.1

		mv src/gkrellm src/gkrellm2
		dobin src/gkrellm2
		rm -f ${D}/usr/bin/gkrellm
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

	insinto /etc
	doins server/gkrellmd.conf

	dodoc COPYRIGHT CREDITS INSTALL README Changelog
	dohtml *.html
}
