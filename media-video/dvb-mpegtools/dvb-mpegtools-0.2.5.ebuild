# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvb-mpegtools/dvb-mpegtools-0.2.5.ebuild,v 1.1 2003/06/12 21:21:49 mholzer Exp $

DESCRIPTION="mpegtools package for manipulation of various MPEG file formats"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=media-video/linuxtv-dvb-1.0.0_pre2"
#RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
    make
}

src_install() {
    mv ${S}/Makefile ${S}/Makefile_orig
    # b0rked at the moment (with 1.0.0-pre2)
    # and modify symlink source ;)
    sed -e s/'cp dvbaudio '/'#cp dvbaudio '/ ${S}/Makefile_orig \
	-e s/'ln -sf $(DESTDIR)dvb-mpegtools $(DESTDIR)$$f ;'/'ln -sf $(LDESTDIR)dvb-mpegtools $(DESTDIR)$$f ;'/ \
	> ${S}/Makefile

    dodir /usr/bin
    make LDESTDIR='/usr/bin/' DESTDIR=${D}/usr/bin/ install || die
    dodoc ${S}/README
}

