# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-2.1.ebuild,v 1.12 2009/06/01 15:03:38 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A command line utility to split mp3 and vorbis files"
HOMEPAGE="http://mp3splt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mp3splt/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa -mips ppc ~ppc64 sparc x86"
IUSE="vorbis"

RDEPEND="vorbis? ( media-libs/libvorbis )
	media-libs/libmad"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_configure() {
	use vorbis || local myconf="--disable-ogg"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
