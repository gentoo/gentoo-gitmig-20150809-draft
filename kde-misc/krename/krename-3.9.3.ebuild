# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-3.9.3.ebuild,v 1.1 2009/06/01 18:07:43 scarabeus Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="KRename - a very powerful batch file renamer."
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/taglib-1.5"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:0
	!${CATEGORY}/${PN}:4.1
"
