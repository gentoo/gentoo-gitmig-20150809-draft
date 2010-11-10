# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-lqr-plugin/gimp-lqr-plugin-0.7.1.ebuild,v 1.1 2010/11/10 21:06:25 phajdan.jr Exp $

DESCRIPTION="Content-aware resizing for the GIMP"
HOMEPAGE="http://liquidrescale.wikidot.com/"
SRC_URI="http://liquidrescale.wikidot.com/local--files/en:download-page-sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-gfx/gimp
	media-libs/liblqr"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die
}
