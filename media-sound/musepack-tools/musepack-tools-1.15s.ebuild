# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musepack-tools/musepack-tools-1.15s.ebuild,v 1.1 2004/11/26 23:03:24 eradicator Exp $

IUSE="static esd oss"

inherit eutils flag-o-matic

S="${WORKDIR}/sv7"

DESCRIPTION="Musepack audio compression tools"
HOMEPAGE="http://www.uni-jena.de/~pfk/mpp/ http://corecodec.org/projects/mpc/ http://www.musepack.net"
SRC_URI="http://www.saunalahti.fi/grimmel/musepack.net/source/mpcsv7-src-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-sound/esound
	 media-libs/id3lib"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	amd64? ( dev-lang/nasm )"

src_unpack() {
	if (! use esd && ! use oss); then
		die "You must have either oss or esd active in your USE flags for xmms-musepack to work properly."
	fi

	unpack ${A}
	cd ${S}

	# Cosmetic changes mainly to allow using of custom CFLAGS
	epatch ${FILESDIR}/${P}-Makefile.patch

	# Get rid of -mpreferred-stack-boundary=2 as it breaks amd64
	sed -i 's:-mpreferred-stack-boundary=2::' Makefile

	use oss || sed -i 's/#define USE_OSS_AUDIO/#undef USE_OSS_AUDIO/' mpp.h

	sed -i 's/#define USE_IRIX_AUDIO/#undef USE_IRIX_AUDIO/' mpp.h

	if ! use esd ; then
		sed -i 's/#define USE_ESD_AUDIO/#undef USE_ESD_AUDIO/' mpp.h
		sed -i 's/LDADD   += -lesd/#LDADD   += -lesd/' Makefile
	fi

	if ! ( use x86 || use amd64 ); then
		sed -i 's/#define USE_ASM/#undef USE_ASM/' mpp.h
	fi
}

src_compile() {
	filter-flags "-fprefetch-loop-arrays"
	filter-flags "-mfpmath=sse" "-mfpmath=sse,387"
	use static && export BLDSTATIC=1
	emake mppenc mppdec replaygain tagger || die
}

src_install() {
	dobin mppenc mppdec replaygain tagger
	dodoc COPYING* README doc/ChangeLog doc/MANUAL.TXT doc/NEWS doc/SV7.txt doc/TODO*
}
