# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rioutil/rioutil-1.2_alpha4.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $

DESCRIPTION="Command line tools for transfering mp3s to and from a Rio 600, 800, and Nike PSA/Play"

HOMEPAGE="http://rioutil.sourceforge.net/"
P=`echo ${P} | sed s/_alpha/a/`
SRC_URI="mirror://sourceforge/rioutil/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${P}"

DEPEND="sys-libs/zlib"

src_compile() {
	econf  --with-usbdevfs
	emake || die
}

src_install() {
	einstall

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
