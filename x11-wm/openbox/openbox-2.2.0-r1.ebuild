# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-2.2.0-r1.ebuild,v 1.1 2002/10/25 10:11:18 mkeadle Exp $

IUSE="nls"

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://icculus.org/openbox/releases/${P}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/"

SLOT="2"
LICENSE="BSD"
KEYWORDS="~x86"

MYBIN="${PN}-dev"
mydoc="CHANGE* TODO LICENSE data/README*"
myconf="--enable-xinerama"
BOOTSTRAP="1"

src_unpack() {

	unpack ${P}.tar.gz
	ssed -i "s:xftlsfonts::" ${S}/util/Makefile.am

}
