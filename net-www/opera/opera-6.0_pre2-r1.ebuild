# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/opera/opera-6.0_pre2-r1.ebuild,v 1.1 2002/01/11 22:52:13 gbevin Exp $

NV=6.0-20011129.2-shared_qt.i386
S=${WORKDIR}/opera-${NV}
DESCRIPTION="Opera webbrowser, version 6.0 TP"
SRC_URI="ftp://ftp.opera.com/pub/opera/linux/600/tp2/opera-${NV}.tar.gz"
HOMEPAGE="http://www.opera.com"

DEPEND=">=x11-libs/qt-2.3.0"

src_install() {

	mv install.sh install.sh_orig
	sed -e "s:/usr/share/pixmaps:${D}/usr/share/pixmaps:g" \
		-e "s:/usr/share/icons:${D}/usr/share/icons:g" \
		-e "s:/etc/X11/wmconfig:${D}/etc/X11/wmconfig:g" \
		-e "s:/usr/share/gnome:${D}/usr/share/gnome:g" \
		install.sh_orig > install.sh
	chmod 755 install.sh
	./install.sh \
		--exec_prefix=${D}/usr/bin \
		--wrapperdir=${D}/usr/share/opera/bin \
		--docdir=${D}/usr/share/doc/${P} \
		--sharedir=${D}/usr/share/opera \
		--plugindir=${D}/usr/share/opera/plugins || die
	rm ${D}/usr/share/doc/${P}/help
	dosym /usr/share/opera/help /usr/share/doc/${P}/help
	dosed /usr/bin/opera
}

