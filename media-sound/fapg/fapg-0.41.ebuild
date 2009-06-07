# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fapg/fapg-0.41.ebuild,v 1.3 2009/06/07 16:36:12 nixnut Exp $

DESCRIPTION="Fast Audio Playlist Generator"
HOMEPAGE="http://royale.zerezo.com/fapg/"
SRC_URI="http://royale.zerezo.com/fapg/${P}.tar.gz"
IUSE="xspf"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 ~sparc ~x86"
RDEPEND="xspf? ( >=dev-libs/uriparser-0.6.3 )"
DEPEND="${RDEPEND}"

src_compile() {
	local myconf=""
	use xspf || myconf="${myconf} --disable-xspf"
	econf ${myconf}
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
