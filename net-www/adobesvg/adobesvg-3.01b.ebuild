# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/adobesvg/adobesvg-3.01b.ebuild,v 1.1 2003/12/31 05:28:21 vapier Exp $

inherit nsplugins

MY_PV=${PV/b/x86}
DESCRIPTION="Scalable Vector Graphics plugin"
HOMEPAGE="http://www.adobe.com/svg/main.html"
SRC_URI="http://download.adobe.com/pub/adobe/magic/svgviewer/linux/3.x/3.0x77/en/${PN}-${MY_PV}-linux-i386.tar.gz"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* x86"

S=${WORKDIR}/${PN}-${PV/b}

src_install() {
	insinto /usr/lib/adobesvg
	doins *.so LICENSE.txt

	dodir /opt/netscape/plugins
	dosym /usr/lib/adobesvg/libNPSVG3.so /opt/netscape/plugins/libNPSVG3.so
	inst_plugin /opt/netscape/plugins/libNPSVG3.so

	dohtml -A svg *.html *.svg
}
