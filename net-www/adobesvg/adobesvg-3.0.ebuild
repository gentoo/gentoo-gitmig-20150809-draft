# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/adobesvg/adobesvg-3.0.ebuild,v 1.1 2003/10/18 20:01:49 vapier Exp $

inherit nsplugins

DESCRIPTION="Scalable Vector Graphics plugin"
HOMEPAGE="http://www.adobe.com/svg/main.html"
SRC_URI="http://download.adobe.com/pub/adobe/magic/svgviewer/linux/3.x/3.0x77/en/${P}-linux-i386.tar.gz"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* x86"

src_install() {
	insinto /usr/lib/${PLUGINS_DIR}
	doins *.so
	dohtml -A svg *.html *.svg
}
