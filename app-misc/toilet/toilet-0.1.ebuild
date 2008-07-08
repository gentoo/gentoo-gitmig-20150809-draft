# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/toilet/toilet-0.1.ebuild,v 1.7 2008/07/08 01:28:16 the_paya Exp $

inherit autotools eutils

DESCRIPTION="The Other Implementations letters. Figlet replacement."
HOMEPAGE="http://libcaca.zoy.org/toilet.html"
SRC_URI="http://libcaca.zoy.org/files/${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libcaca"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded-and-cflags.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog NEWS README TODO
}
