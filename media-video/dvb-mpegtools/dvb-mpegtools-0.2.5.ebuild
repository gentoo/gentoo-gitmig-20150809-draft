# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvb-mpegtools/dvb-mpegtools-0.2.5.ebuild,v 1.2 2003/06/18 12:54:58 seemant Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="mpegtools package for manipulation of various MPEG file formats"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	>=media-tv/linuxtv-dvb-1.0.0_pre2"

src_compile() {
	make || die
}

src_install() {
    # b0rked at the moment (with 1.0.0-pre2)
    # and modify symlink source ;)
    sed -i \
		-e s/'cp dvbaudio '/'#cp dvbaudio '/ \
		-e s/'ln -sf $(DESTDIR)dvb-mpegtools $(DESTDIR)$$f ;'/'ln -sf $(LDESTDIR)dvb-mpegtools $(DESTDIR)$$f ;'/ \
		${S}/Makefile

    dodir /usr/bin
    make LDESTDIR='/usr/bin/' DESTDIR=${D}/usr/bin/ install || die
    dodoc ${S}/README
}

