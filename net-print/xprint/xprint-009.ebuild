# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xprint/xprint-009.ebuild,v 1.1 2004/04/12 00:59:32 lanius Exp $

DESCRIPTION="An advanced printing system which enables X11 applications to use devices like printers in formats like PostScript, PDF, PCL, etc."
HOMEPAGE="http://xprint.mozdev.org"
SRC_URI="mirror://sourceforge/xprint/xprint_mozdev_org_source-2004-03-22-release_009.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/x11
	!app-arch/star"
RDEPEND="virtual/x11
	virtual/lpr"
IUSE=""

S=${WORKDIR}/xprint/src/xprint_main/xc/

src_compile() {
	sed 's:XPRINTDIR = .*$:XPRINTDIR = /usr/share/Xprint/xserver:' -i config/cf/X11.tmpl
	make XPRINTDIR=/usr/share/Xprint/xserver World || die
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

	sed -i -e 's:XPCUSTOMGLUE=default:XPCUSTOMGLUE=DebianGlue:' ${D}/usr/sbin/xprint
}

pkg_postinst() {
	einfo
	einfo '                        You have to add                            '
	einfo 'export XPSERVERLIST="`/bin/sh /usr/sbin/xprint get_xpserverlist`"'
	einfo '          to your .xinitrc to get things working correctly         '
	einfo
}
