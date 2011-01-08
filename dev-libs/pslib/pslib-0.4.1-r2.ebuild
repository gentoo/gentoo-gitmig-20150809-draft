# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pslib/pslib-0.4.1-r2.ebuild,v 1.3 2011/01/08 02:01:16 ranger Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="pslib is a C-library to create PostScript files on the fly."
HOMEPAGE="http://pslib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pslib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc ~x86"
IUSE="debug jpeg png tiff"

RDEPEND="png? ( >=media-libs/libpng-1.2.43-r2:0 )
	jpeg? ( media-libs/jpeg:0 )
	tiff? ( media-libs/tiff )"
#gif? requires libungif, not in portage
DEPEND="${RDEPEND}
	dev-lang/perl
	>=dev-libs/glib-2
	dev-util/intltool
	dev-perl/XML-Parser"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-lm.patch \
		"${FILESDIR}"/${PN}-getline.patch

	sed -i \
		-e 's:png_set_gray_1_2_4_to_8:png_set_expand_gray_1_2_4_to_8:' \
		src/pslib.c || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with tiff) \
		$(use_with debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README
}
