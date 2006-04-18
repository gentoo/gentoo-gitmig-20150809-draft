# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musepack-tools/musepack-tools-1.15v.ebuild,v 1.7 2006/04/18 17:46:49 flameeyes Exp $

IUSE="static 16bit esd"

inherit eutils flag-o-matic

S="${WORKDIR}/sv7"

DESCRIPTION="Musepack audio compression tools"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://files.musepack.net/source/mpcsv7-src-${PV}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 x86"

RDEPEND="esd? ( media-sound/esound )
	 media-libs/id3lib"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	amd64? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-Makefile.patch
	epatch ${FILESDIR}/${P}-gcc4.patch

	sed -i 's/#define USE_IRIX_AUDIO/#undef USE_IRIX_AUDIO/' mpp.h

	if ! use esd ; then
		sed -i -e 's/#define USE_ESD_AUDIO/#undef USE_ESD_AUDIO/' mpp.h
	else
		sed -i -e 's/^LDADD    = -lm$/LDADD    = $(shell esd-config --libs)/' \
			Makefile
	fi

	if ! use x86 ; then
		sed -i 's/#define USE_ASM/#undef USE_ASM/' mpp.h
	fi

	use 16bit && sed -i 's|//#define MAKE_16BIT|#define MAKE_16BIT|' mpp.h

	# Bug #109699; console redirection to /dev/tty makes no sense
	sed -i -e 's/$(LDADD) &> $(LOGFILE)/$(LDADD)/' Makefile

	epatch "${FILESDIR}/${P}-execstack.patch"
}

src_compile() {
	filter-flags "-fprefetch-loop-arrays"
	filter-flags "-mfpmath=sse" "-mfpmath=sse,387"
	use static && export BLD_STATIC=1

	append-flags -I${S}

	ARCH= emake mppenc mppdec replaygain || die
}

src_install() {
	dobin mppenc mppdec replaygain
	dodoc README doc/ChangeLog doc/MANUAL.TXT doc/NEWS doc/SV7.txt doc/TODO*
}
