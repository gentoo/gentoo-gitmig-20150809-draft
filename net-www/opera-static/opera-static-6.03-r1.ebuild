# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/opera-static/opera-static-6.03-r1.ebuild,v 1.3 2003/02/13 15:41:31 vapier Exp $

DESCRIPTION="Opera web browser, statically built."
HOMEPAGE="http://www.opera.com/linux/"
LICENSE="OPERA"

DEPEND="virtual/x11
        x11-libs/lesstif"
KEYWORDS="x86 -ppc sparc "
SLOT="0"

NV=6.03-20020813.1-static-qt.i386
SRC_URI="http://www.panix.com/opera/files/linux/603/final/en/qt_static/opera-${NV}.tar.bz2"
S=${WORKDIR}/opera-${NV}


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
