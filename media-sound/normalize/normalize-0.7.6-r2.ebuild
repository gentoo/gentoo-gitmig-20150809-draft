# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/normalize/normalize-0.7.6-r2.ebuild,v 1.6 2004/11/25 09:33:45 eradicator Exp $

IUSE="xmms mad audiofile nls"

DESCRIPTION="Audio file volume normalizer"
HOMEPAGE="http://www.cs.columbia.edu/~cvaill/normalize"
SRC_URI="http://www1.cs.columbia.edu/~cvaill/normalize/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"

RDEPEND="xmms? ( >=media-sound/xmms-1.2.7-r6 )
	 mad? ( media-libs/libmad )
	 audiofile? ( >=media-libs/audiofile-0.2.3-r1 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
	econf \
		`use_enable nls` \
		`use_with mad` \
		`use_enable xmms` \
		`use_with audiofile` \
		`use_with pic` \
		${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc NEWS README THANKS TODO
}
