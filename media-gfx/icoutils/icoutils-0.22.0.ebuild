# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icoutils/icoutils-0.22.0.ebuild,v 1.5 2006/03/06 14:10:22 flameeyes Exp $

DESCRIPTION="A set of programs for extracting and converting images in Microsoft Windows icon and cursor files (.ico, .cur)."
HOMEPAGE="http://www.student.lu.se/~nbi98oli"
SRC_URI="http://www.student.lu.se/~nbi98oli/src/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

RDEPEND="media-libs/libpng
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		`use_enable nls` \
		--disable-dependency-tracking || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
