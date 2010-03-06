# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icoutils/icoutils-0.29.1.ebuild,v 1.1 2010/03/06 09:33:05 patrick Exp $

DESCRIPTION="A set of programs for extracting and converting images in Microsoft Windows icon and cursor files (.ico, .cur)."
HOMEPAGE="http://www.nongnu.org/icoutils/"
SRC_URI="http://savannah.nongnu.org/download/icoutils/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

RDEPEND="media-libs/libpng
		nls? ( virtual/libintl )
		>=dev-lang/perl-5.6
		>=dev-perl/libwww-perl-5.64"

DEPEND="${RDEPEND}
		nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		`use_enable nls` \
		--disable-dependency-tracking || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
