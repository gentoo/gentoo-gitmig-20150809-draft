# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.8.1-r1.ebuild,v 1.2 2004/01/26 00:42:50 vapier Exp $

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz \
	mirror://sourceforge/hydrogen/3355606.tar.gz \
	mirror://sourceforge/hydrogen/DrumkitPack1.tar.gz \
	mirror://sourceforge/hydrogen/DrumkitPack2.tar.gz \
	mirror://sourceforge/hydrogen/EasternHop-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	>=x11-libs/qt-3
	alsa? ( media-libs/alsa-lib )
	virtual/jack"

src_unpack() {
	unpack ${A}

	# Drum kits to install
	local KITS
	KITS="3355606kit EasternHop-1 HipHop-1 HipHop-2 Synthie-1 TR808909 Techno-1"

	# Grab our drumkits
	cd ${P}/data/drumkits
	tar zxf ${WORKDIR}/3355606/3355606kit.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack1/HipHop-1.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack1/HipHop-2.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack2/Synthie-1.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack2/TR808909.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack2/Techno-1.h2drumkit
	tar zxf ${WORKDIR}/EasternHop-1/EasternHop-1.h2drumkit

	# Recurse into drumkit directories
	sed -ie "s:GMkit:GMkit ${KITS}:" Makefile.am

	# Set up drumkit Makefiles, model after GMkit

	for kit in ${KITS}
	do
		cd ${kit}
		cp ../GMkit/Makefile.* .
		sed -ie "s:GMkit:${kit}:" Makefile.am
		sed -i "/AC_CONFIG_FILES(\[ data\\/drumkits\\/GMkit/i\\AC_CONFIG_FILES([ data/drumkits/${kit}/Makefile ])\\" ${S}/configure.in
		cd ..
	done
}

src_compile() {
	einfo "Reconfiguring..."
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.6

	./autogen.sh

	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog FAQ README TODO
}
