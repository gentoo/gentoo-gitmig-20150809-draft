# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblingoteach/liblingoteach-0.2.3.ebuild,v 1.1 2008/04/24 11:21:42 drac Exp $

DESCRIPTION="A library to support lingoteach-ui and for generic lesson development."
HOMEPAGE="http://lingoteach.sourceforge.net"
SRC_URI="mirror://sourceforge/lingoteach/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc"
IUSE="debug zlib"

RDEPEND="zlib? ( sys-libs/zlib )
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable zlib compression) \
		$(use_enable debug)

	emake || die "emake failed."
}

src_install() {
	emake HTML_DIR="/usr/share/doc/${PF}" DOC_MODULE="" \
		DESTDIR="${D}" install || die "emake install failed."

	dodoc AUTHORS ChangeLog HACKING NEWS README
}
