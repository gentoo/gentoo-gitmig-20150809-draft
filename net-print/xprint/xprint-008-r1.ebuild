# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xprint/xprint-008-r1.ebuild,v 1.2 2003/09/07 00:18:10 msterret Exp $

DESCRIPTION="An advanced printing system which enables X11 applications to use devices like printers in formats like PostScript, PDF, PCL, etc."
HOMEPAGE="http://xprint.mozdev.org"
SRC_URI="http://puck.informatik.med.uni-giessen.de/download/xprint_mozdev_org_source-2003-05-08-release_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
DEPEND="x11-base/xfree"
RDEPEND="virtual/lpr"
IUSE=""

S=${WORKDIR}/xprint/src/xprint_main/xc/

src_compile() {
	make World || die
}

src_install() {
	make XPRINTDIR=/usr/share/Xprint/xserver XPDESTTARFILE=${S}/xprint.tar.gz make_xprint_tarball -C ${S}/packager

	tar -xzf xprint.tar.gz
	mv xprint/install/* ${D}

	# this is a really nasty package, so we have to clean up a bit
	rm -fR ${D}/etc/X11/
	rm -fR ${D}/etc/profile.d
	dodir /usr/sbin
	mv ${D}/etc/init.d/xprint ${D}/usr/sbin/
	cp ${FILESDIR}/xprint.rc6 ${D}/etc/init.d/xprint
	dodoc ${D}/usr/X11R6/lib/X11/xserver/README
	rm -f ${D}/usr/X11R6/lib/X11/xserver/README
}

pkg_postinst() {
	einfo
	einfo '                        You have to add                            '
	einfo 'export XPSERVERLIST="`/bin/sh /etc/init.d/xprint get_xpserverlist`"'
	einfo '          to your .xinitrc to get things working correctly         '
	einfo
}
