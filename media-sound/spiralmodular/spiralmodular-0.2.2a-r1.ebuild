# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/spiralmodular/spiralmodular-0.2.2a-r1.ebuild,v 1.6 2008/04/28 17:01:35 drac Exp $

inherit eutils multilib

DESCRIPTION="SSM is a object oriented modular softsynth/ sequencer/ sampler."
HOMEPAGE="http://www.pawfal.org/Software/SSM/"
SRC_URI="mirror://sourceforge/spiralmodular/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="alsa jack"

DEPEND=">=x11-libs/fltk-1.1
	media-libs/libsndfile
	media-libs/liblrdf
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	media-libs/ladspa-sdk"

S=${WORKDIR}/${PN}-0.2.2

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	for file in `find . -name Makefile.in`; do
		sed -i s/CXXFLAGS=\\t@CXXFLAGS@/CXXFLAGS=\\t@CXXFLAGS@\ @FLTK_CXXFLAGS@/ $file
		sed -i s/CFLAGS\\t=\\t@CFLAGS@/CFLAGS\\t=\\t@CFLAGS@\ @FLTK_CFLAGS@/ $file
	done

	# NOTE: We can't do use_enable for this package as it believe --enable-a and --disable-a both mean disable
	local myconf;
	if ! use jack; then
		myconf="${myconf} --disable-jack"
	fi

	if ! use alsa; then
		myconf="${myconf} --disable-alsa-midi"
	fi

	econf ${myconf}
	emake || die "emake failed."
}

src_install() {
	dodir /usr/bin /usr/$(get_libdir) /usr/share/man /usr/share/info
	dodoc Examples/*
	emake bindir="${D}/usr/bin" libdir="${D}/usr/$(get_libdir)" \
		mandir="${D}/usr/share/man" infodir="${D}/usr/share/info" \
		datadir="${D}/usr/share" install || die "emake install failed."
}
