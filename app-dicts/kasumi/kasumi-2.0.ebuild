# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/kasumi/kasumi-2.0.ebuild,v 1.3 2006/06/25 20:49:55 flameeyes Exp $

inherit eutils autotools

DESCRIPTION="Anthy dictionary maintenance tool"
HOMEPAGE="http://kasumi.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/20334/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	>=media-libs/freetype-2
	>=dev-libs/atk-1.4
	>=dev-libs/expat-1.95
	>=x11-libs/pango-1.2
	nls? ( virtual/libintl )
	virtual/libiconv
	app-i18n/anthy"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-nls.patch"
	epatch "${FILESDIR}/${P}-virtual-destructors.patch"
	epatch "${FILESDIR}/${P}-format.patch"
	epatch "${FILESDIR}/${P}-fbsd.patch"

	eautoreconf
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README ChangeLog AUTHORS
}
