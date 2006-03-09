# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/kasumi/kasumi-0.10.ebuild,v 1.7 2006/03/09 19:31:05 flameeyes Exp $

inherit eutils

DESCRIPTION="Anthy dictionary maintenance tool"
HOMEPAGE="http://kasumi.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/16557/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	>=media-libs/freetype-2
	>=dev-libs/atk-1.4
	>=dev-libs/expat-1.95
	>=x11-libs/pango-1.2
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-gcc41.patch"
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README ChangeLog AUTHORS
}
