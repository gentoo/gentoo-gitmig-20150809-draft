# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/opera-static/opera-static-6.0-r1.ebuild,v 1.2 2002/07/04 17:00:43 agenkin Exp $

DESCRIPTION="Opera web browser, version 6.0 Final, statically built. "
HOMEPAGE="http://www.opera.com/linux/"

DEPEND="virtual/x11
	virtual/glibc"

NV=6.0-20020510.1-static-qt.i386
SRC_URI="http://www.panix.com/opera/files/linux/600/final/en/qt_static/opera-${NV}.tar.bz2"
S=${WORKDIR}/opera-${NV}

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
	dosed /usr/bin/opera

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

	# Fix up the wrapper script /opt/opera/share/bin/opera
	cd "${D}"/opt/opera/share/bin
	sed -e "s|$D||g" < opera > opera.hacked
	mv opera.hacked opera
}
