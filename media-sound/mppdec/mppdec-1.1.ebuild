# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mppdec/mppdec-1.1.ebuild,v 1.1 2004/04/17 08:12:54 eradicator Exp $

inherit eutils

DESCRIPTION="Frank Klemm's Musepack Decoder"
HOMEPAGE="http://www.musepack.tk"
SRC_URI="http://www.personal.uni-jena.de/~pfk/MPP/src/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="esd static"

RDEPEND="esd? ( media-sound/esound )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if ! use static; then
		epatch ${FILESDIR}/${P}-nostatic.patch
	fi

	if ! use esd ; then
		sed -i 's/#define USE_ESD_AUDIO/#undef USE_ESD_AUDIO/' mpp.h
		sed -i 's/LDADD   += -lesd/#LDADD   += -lesd/' Makefile
	fi
	use x86 || sed -i 's/#define USE_ASM/#undef USE_ASM/' mpp.h
}

src_compile() {
	# Makefile inserts $ARCH into cc command line and ignores global CFLAGS
	ARCH="${CFLAGS}" make mppdec || die
}

src_install() {
	if use static; then
		newbin mppdec-static mppdec
	else
		dobin mppdec
	fi

	dodoc AUTHORS ChangeLog COPYING.LGPL MANUAL.TXT README SV7.txt
}
