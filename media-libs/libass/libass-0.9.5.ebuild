# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libass/libass-0.9.5.ebuild,v 1.12 2009/04/04 18:57:22 solar Exp $

inherit autotools eutils

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="http://sourceforge.net/projects/libass/"
SRC_URI="mirror://sourceforge/libass/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm alpha amd64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="enca iconv png"

RDEPEND=">=media-libs/fontconfig-2.2.0
	>=media-libs/freetype-2.1.10
	png? ( >=media-libs/libpng-1.2.15 )
	iconv? ( virtual/libiconv )
	enca? ( app-i18n/enca )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}_automagic.patch"
	eautoreconf
}

src_compile() {
	econf \
		$(use_with enca) \
		$(use_with iconv) \
		$(use_with png)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Changelog
}
