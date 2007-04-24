# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/normalize/normalize-0.7.7.ebuild,v 1.3 2007/04/24 12:18:08 armin76 Exp $

DESCRIPTION="Audio file volume normalizer"
HOMEPAGE="http://normalize.nongnu.org/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="mad audiofile nls"

RDEPEND="mad? ( media-libs/libmad )
	 audiofile? ( >=media-libs/audiofile-0.2.3-r1 )"
DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_with mad) \
		--disable-xmms \
		$(use_with audiofile) \
		|| die

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README THANKS TODO
}
