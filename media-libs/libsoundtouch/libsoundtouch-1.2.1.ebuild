# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsoundtouch/libsoundtouch-1.2.1.ebuild,v 1.2 2004/08/30 15:45:47 dholm Exp $

DESCRIPTION="Audio processing library for changing the tempo, pitch and playback rates."
HOMEPAGE="http://sky.prohosting.com/oparviai/soundtouch/"
SRC_URI="http://sky.prohosting.com/oparviai/soundtouch/soundtouch_v${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

# FIXME:
#
# I wanted to use 'static' and 'pic' USE flags, but anything
# other than a static lib produces segfaults in soundstretch. :-(
# So I let alone the '$myconf' option, so one can test options
# easily with: myconf="--enable-foo" emerge libsoundtouch

DEPEND=""
S="${WORKDIR}/SoundTouch-${PV}"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}

	# change sample type from integer to float (more accurate)
	sed -i -e "s|#define INTEGER_SAMPLES|//#define INTEGER_SAMPLES|g" \
		-e "s|//#define FLOAT_SAMPLES|#define FLOAT_SAMPLES|g" include/STTypes.h
}

src_compile() {
	econf $myconf || die "./configure failed"
	# fixes C(XX)FLAGS from configure, so we can use *ours*
	emake CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} pkgdocdir=/usr/share/doc/${P} install || die
	rm -f ${D}/usr/share/doc/${P}/COPYING.TXT  # remove obsolete LICENCE file
}
