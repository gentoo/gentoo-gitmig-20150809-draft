# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/media-video/vcr/vcr-1.08.ebuild
# ${P} == package name <path>/<$P>.ebuild
# ${D} == temporary directory where to install the stuff (/tmp/portage/<$P>/image)
# ${WORKDIR} == /tmp/portage/${P}/work

S=${WORKDIR}/${P}
DESCRIPTION="Console base vcr program"
SRC_URI="http://www.stack.nl/~brama/vcr/src/${P}.tar.gz"

HOMEPAGE="http://www.stack.nl/~brama/vcr/index.html"

#DEPEND="avifile 0.53 || 0.6"
#RDEPEND="??"

src_unpack() {
  unpack ${P}.tar.gz
}

src_compile() {
# some more experienced might make chech here if we have avifile 0.53 or 0.6
# and add --enable-avifile-0_6 to configure then

    export CFLAGS=${CFLAGS/-O?/-O2}
    try autoconf
    try automake
    try LDFLAGS="$LDFLAGS" ./configure --host=${CHOST} --prefix=/usr --with-avifile-libs=/usr/X11R6/lib
    try make

}

src_install () {
    make prefix=${D}/usr install

    cd ${S}
    dodoc README TODO NEWS COPYING AUTHORS INSTALL vcr.1
    cd doc
    dodoc README.vcrtimer program_vcr.sh sample.vcrrc sample.vcrtimerrc
    dodoc vcrtimer.pl
}

