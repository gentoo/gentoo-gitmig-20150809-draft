# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/normalize/normalize-0.7.6-r2.ebuild,v 1.10 2006/11/13 15:19:05 flameeyes Exp $

IUSE="mad audiofile nls"

DESCRIPTION="Audio file volume normalizer"
HOMEPAGE="http://www.cs.columbia.edu/~cvaill/normalize"
SRC_URI="http://www1.cs.columbia.edu/~cvaill/normalize/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"

RDEPEND="mad? ( media-libs/libmad )
	 audiofile? ( >=media-libs/audiofile-0.2.3-r1 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
	econf \
		`use_enable nls` \
		`use_with mad` \
		`use_with audiofile` \
		--disable-xmms \
		${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc NEWS README THANKS TODO
}
