# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gifsicle/gifsicle-1.40.ebuild,v 1.3 2004/11/18 22:43:34 sekretarz Exp $

DESCRIPTION="A UNIX command-line tool for creating, editing, and getting information about GIF images and animations"
HOMEPAGE="http://www.lcdf.org/~eddietwo/gifsicle/"
SRC_URI="http://www.lcdf.org/~eddietwo/gifsicle/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"

IUSE="X"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	local myconf
	use X || myconf="${myconf} --disable-gifview"
	econf ${myconf} || die "econf failed"
	emake           || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc NEWS README         || die "dodoc failed"
}
