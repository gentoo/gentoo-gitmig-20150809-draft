# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lives/lives-0.7.1.ebuild,v 1.1 2003/09/03 22:13:24 lu_zero Exp $

DESCRIPTION="Linux Video Editing System"

HOMEPAGE="http://www.xs4all.nl/~salsaman/lives"

MY_PN=LiVES
MY_P=${MY_PN}-${PV}

SRC_URI="http://www.xs4all.nl/~salsaman/lives/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE="xmms"

DEPEND=">=media-video/mplayer-0.90-r2
		>=media-gfx/imagemagick-5.5.6
		>=dev-lang/perl-5.8.0-r12
		>=x11-libs/gtk+-2.2.1
		media-libs/gdk-pixbuf
		>=media-libs/jpeg-6b-r3
		>=media-sound/sox-12.17.3-r3
		xmms? ( >=media-sound/xmms-1.2.7-r20 )
		>=app-cdr/cdrtools-2.01_alpha14"

RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
		econf || die
		emake || die
}

src_install() {
		einstall || die
		insinto /usr/bin
		dobin ${S}/smogrify || die
		dobin ${S}/midistart || die
		dobin ${S}/midistop || die
		dodoc AUTHORS CHANGELOG FEATURES GETTING.STARTED
}
