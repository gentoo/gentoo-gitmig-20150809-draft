# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/normalize/normalize-0.7.6-r1.ebuild,v 1.1 2003/07/17 22:18:41 raker Exp $

IUSE="xmms"

DESCRIPTION="Audio file volume normalizer"
HOMEPAGE="http://www.cs.columbia.edu/~cvaill/normalize"
SRC_URI="http://www.cs.columbia.edu/~cvaill/normalize/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2" 
KEYWORDS="~x86 ~ppc"

RDEPEND="xmms? ( >=media-sound/xmms-1.2.7-r6 )
	>=media-libs/audiofile-0.2.3-r1
	>=media-libs/libmad-0.15.0b
	>=media-libs/libid3tag-0.15.0b"

src_compile() {
	econf \
		--with-audiofile \
		--with-mad || die

	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die
}
