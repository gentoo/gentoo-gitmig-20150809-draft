# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit libtool

DESCRIPTION="Linux Drum Machine - Libary"
HOMEPAGE="http://hydrogen.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/hydrogen/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${P}"

DEPEND="virtual/x11 \
        >=media-libs/audiofile-0.2.3 \
        alsa? ( media-libs/alsa-lib ) \
        virtual/jack"

src_compile() {
        einfo "Reconfiguring..."
        export WANT_AUTOCONF_2_5=1
        aclocal
        autoconf
        automake

        elibtoolize

	econf
	emake || die
}

 src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog FAQ README TODO
}


