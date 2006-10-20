# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-2.1.ebuild,v 1.10 2006/10/20 21:51:59 kloeri Exp $

inherit eutils

DESCRIPTION="A command line utility to split mp3 and vorbis files"
HOMEPAGE="http://mp3splt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mp3splt/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa -mips ppc sparc x86"
IUSE="vorbis"

DEPEND="vorbis? ( media-libs/libvorbis )
	media-libs/libmad"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	local myconf

	# --enable-ogg doesn't enable ogg...
	use vorbis || myconf="--disable-ogg"
	econf ${myconf} || die "econf failed"

	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
