# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/adplay/adplay-1.4.ebuild,v 1.2 2004/11/11 10:09:58 eradicator Exp $

IUSE="oss esd sdl"

DESCRIPTION="A console player for AdLib music"
HOMEPAGE="http://adplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/adplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND=">=media-libs/adplug-1.4.1"

src_compile() {
	local myconf

	use oss || myconf="${myconf} --disable-output-oss"
	use esd || myconf="${myconf} --disable-output-esound"
	use sdl || myconf="${myconf} --disable-output-sdl"

	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}
