# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amsynth/amsynth-1.0_rc2.ebuild,v 1.1 2003/07/02 11:58:14 torbenh Exp $

MY_P=${P/_rc/-rc}
MY_P=${MY_P/amsynth/amSynth}

DESCRIPTION="A retro analogue - modelling softsynth"
HOMEPAGE="http://amsynthe.sourceforge.net/"
SRC_URI="mirror://sourceforge/amsynthe/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="oss alsa jack"

# libsndfile support is actually optional, but IMHO this package should have it
DEPEND="=x11-libs/gtkmm-1.2* \
	media-libs/libsndfile \
	alsa? ( media-libs/alsa-lib \
		media-sound/alsa-utils ) \
	jack? ( virtual/jack )"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf
	use oss || myconf="--without-oss ${myconf}"
	use alsa || myconf="--without-alsa ${myconf}"
	use jack || myconf="--without-jack ${myconf}"
	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo ""
	einfo "amSynth has been installed normally."
	einfo "If you would like to use the virtual"
	einfo "keyboard option, then do"
	einfo "emerge vkeybd"
	einfo "and make sure you emerged amSynth"
	einfo "with alsa support (USE=alsa)"
	einfo ""
}
