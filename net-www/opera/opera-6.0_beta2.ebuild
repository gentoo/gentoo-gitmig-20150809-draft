# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/opera/opera-6.0_beta2.ebuild,v 1.3 2002/07/14 20:25:23 aliz Exp $

NV=6.0-20020412.2-shared-qt.i386
S=${WORKDIR}/opera-${NV}
DESCRIPTION="Opera webbrowser, version 6.0 Beta 2"
SRC_URI="ftp://ftp.opera.com/pub/opera/linux/600/beta2/opera-${NV}.tar.bz2"
HOMEPAGE="http://www.opera.com"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/qt-2*"

src_install() {

	mv install.sh install.sh_orig
	sed -e "s:/usr/share/pixmaps:${D}/usr/share/pixmaps:g" \
		-e "s:/usr/share/applnk:${D}/usr/share/applnk:g" \
		-e "s:/usr/share/icons:${D}/usr/share/icons:g" \
		-e "s:/etc/X11:${D}/etc/X11:g" \
		-e "s:/usr/share/gnome:${D}/usr/share/gnome:g" \
		install.sh_orig > install.sh
	chmod 755 install.sh
	./install.sh \
		--exec_prefix=${D}/opt/opera/bin \
		--wrapperdir=${D}/opt/opera/share/bin \
		--docdir=${D}/usr/share/doc/${P} \
		--sharedir=${D}/opt/opera/share \
		--plugindir=${D}/opt/opera/share/plugins || die

	rm ${D}/usr/share/doc/${P}/help
	dosym /usr/share/opera/help /usr/share/doc/${P}/help

	mv ${D}/opt/opera/bin/opera ${D}/opt/opera/bin/opera-bin
	mv ${D}/opt/opera/share/bin/opera ${D}/opt/opera/bin/opera
	dosed /opt/opera/bin/opera

	mv ${D}/opt/opera/bin/opera ${D}/opt/opera/bin/opera.orig
	sed -e "s:OPERA=/opt/opera/bin/opera:OPERA=/opt/opera/bin/opera-bin:" \
		< ${D}/opt/opera/bin/opera.orig \
		> ${D}/opt/opera/bin/opera
	rm ${D}/opt/opera/bin/opera.orig
	chmod 755 ${D}/opt/opera/bin/opera



	#install the icons
	insinto /usr/share/icons /etc/X11/wmconfig /etc/X11/applnk/Internet /usr/share/pixmaps /usr/share/gnome/pixmaps
	doins images/opera.xpm
	insinto /etc/X11/wmconfig 
	doins images/opera.xpm
	insinto /etc/X11/applnk/Internet 
	doins images/opera.xpm
	insinto /usr/share/pixmaps 	
	doins images/opera.xpm
	
	if [ "`use gnome`" ]
	then
		insinto /usr/share/gnome/pixmaps
		doins images/opera.xpm
	fi

}
