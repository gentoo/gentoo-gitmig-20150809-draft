# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liboggz/liboggz-0.9.5.ebuild,v 1.1 2007/08/22 17:32:58 drac Exp $

DESCRIPTION="Oggz provides a simple programming interface for reading and writing Ogg files and streams"
HOMEPAGE="http://www.annodex.net/software/liboggz"
SRC_URI="http://downloads.xiph.org/releases/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="media-libs/libogg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
	doman doc/*.1
	use doc || rm -rf "${D}"/usr/share/doc/${PN}
}
