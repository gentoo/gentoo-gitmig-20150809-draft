# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table-cantonese/ibus-table-cantonese-1.2.0.20090824.ebuild,v 1.1 2009/09/21 23:58:48 matsuu Exp $

EAPI="2"

DESCRIPTION="The Cantonese input method table for IBus-Table"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-i18n/ibus-table-1.1"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
