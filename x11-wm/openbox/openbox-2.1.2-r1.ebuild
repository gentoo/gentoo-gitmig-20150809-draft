# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://icculus.org/${PN}/releases/${P}.tar.gz"
HOMEPAGE="http://icculus.org/${PN}"

SLOT="1"
LICENSE="BSD"
KEYWORDS="x86 sparc "

MYBIN="${PN}"
mydoc="CHANGE* TODO LICENSE data/README*"
myconf="--enable-xinerama"
BOOTSTRAP="1"

src_unpack() {

   unpack ${P}.tar.gz
   sed -i "s:xftlsfonts::" ${S}/util/Makefile.am
   
}
