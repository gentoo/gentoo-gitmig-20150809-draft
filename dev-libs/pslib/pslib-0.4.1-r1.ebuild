# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pslib/pslib-0.4.1-r1.ebuild,v 1.4 2009/11/21 17:30:30 maekke Exp $

inherit autotools eutils

DESCRIPTION="pslib is a C-library to create PostScript files on the fly."
HOMEPAGE="http://pslib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pslib/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug jpeg png tiff"

RDEPEND="png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )"
#gif? requires libungif, not in portage
DEPEND="${RDEPEND}
	dev-lang/perl
	>=dev-libs/glib-2
	dev-util/intltool
	dev-perl/XML-Parser"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-lm.patch"
	epatch "${FILESDIR}/${PN}-getline.patch"
	eautoreconf
}

src_compile() {
	econf $(use_with png) \
		$(use_with jpeg) \
		$(use_with tiff) \
		$(use_with debug) \
		|| die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install failed"
	dodoc AUTHORS README
}
