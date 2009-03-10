# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cuecue/cuecue-0.2.2-r1.ebuild,v 1.5 2009/03/10 22:08:00 beandog Exp $

EAPI="1"
inherit eutils

DESCRIPTION="Cuecue is a suite to convert .cue + [.ogg|.flac|.wav|.mp3] to .cue + .bin."
HOMEPAGE="http://cuecue.berlios.de/"
SRC_URI="mirror://berlios/cuecue/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Enable one use flag by default, bug 254745"
IUSE="flac mp3 +vorbis"

DEPEND="mp3? ( media-libs/libmad )
	flac? ( media-libs/flac )
	vorbis? ( media-libs/libvorbis media-libs/libogg )"

pkg_setup() {
	for X in ${IUSE}; do
		use ${X} && return 0
	done
	eerror "You must enable at least one of these USE flags: ${IUSE}"
	die "no format, no compile! ;-)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-flac113.diff # bug 157706
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable mp3) \
		$(use_enable vorbis ogg) \
		--disable-oggtest \
		--disable-vorbistest \
		$(use_enable flac) \
		--disable-libFLACtest \
		|| die "econf failed."

	emake CFLAGS="-ansi -pedantic ${CFLAGS}" \
		|| die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	insinto /usr/include
	doins src/libcuecue/cuecue.h || die "doins failed."
	dodoc CHANGES README TODO
}
