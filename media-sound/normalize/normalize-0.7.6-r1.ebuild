# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/normalize/normalize-0.7.6-r1.ebuild,v 1.7 2004/02/07 19:38:20 vapier Exp $

DESCRIPTION="Audio file volume normalizer"
HOMEPAGE="http://www.cs.columbia.edu/~cvaill/normalize"
SRC_URI="http://www1.cs.columbia.edu/~cvaill/normalize/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64"
IUSE="xmms mad"

RDEPEND="xmms? ( >=media-sound/xmms-1.2.7-r6 )
	mad? ( >=media-sound/mad-0.14.2b )
	>=media-libs/audiofile-0.2.3-r1"

src_compile() {
	local myconf
	myconf=""
	use mad && myconf="${myconf} --with-mad"
	econf \
		--with-audiofile \
		${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
