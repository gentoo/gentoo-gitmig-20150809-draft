# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/opera-static/opera-static-6.02.ebuild,v 1.4 2002/07/17 01:40:22 seemant Exp $

NV=6.02-20020701.1-static-qt.i386
S=${WORKDIR}/opera-${NV}
DESCRIPTION="Opera web browser, statically built."
HOMEPAGE="http://www.opera.com/linux/"
SRC_URI="http://www.panix.com/opera/files/linux/602/final/en/qt_static/opera-${NV}.tar.bz2"
SLOT="0"
KEYWORDS="x86"
LICENSE="OPERA"

DEPEND="virtual/x11"

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -e "s:/etc:${D}/etc:g" \
	    -e "s:read install_config:install_config=yes:" \
	    -e "s:/usr/share/applnk:${D}/usr/share/applnk:g" \
	    -e "s:/usr/share/pixmaps:${D}/usr/share/pixmaps:g" \
	    -e "s:/usr/share/icons:${D}/usr/share/icons:g" \
	    -e "s:/etc/X11:${D}/etc/X11:g" \
	    -e "s:/usr/share/gnome:${D}/usr/share/gnome:g" \
	    < install.sh >install.sh.hacked || die
	mv install.sh.hacked install.sh
	chmod +x install.sh

}

src_install() {

	dodir /etc
	./install.sh --prefix="${D}"/opt/opera || die
	rm ${D}/opt/opera/share/doc/opera/help
	dosym /opt/share/doc/opera/help /opt/opera/share/opera/help
	dosed /opt/opera/bin/opera

	#install the icons
	insinto /usr/share/icons /etc/X11/wmconfig /etc/X11/applnk/Internet \
		/usr/share/pixmaps /usr/share/gnome/pixmaps
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

	insinto /etc/env.d
	doins ${FILESDIR}/10opera6
}
