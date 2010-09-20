# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/opencc/opencc-0.1.2.ebuild,v 1.1 2010/09/20 02:46:56 matsuu Exp $

EAPI=3

DESCRIPTION="Libraries for Simplified-Traditional Chinese Conversion"
HOMEPAGE="http://code.google.com/p/open-chinese-convert/"
SRC_URI="http://open-chinese-convert.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_configure() {
	econf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}
