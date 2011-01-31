# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/qtrans/qtrans-0.2.2.6.ebuild,v 1.2 2011/01/31 06:25:39 tampakrap Exp $

EAPI=3
WEBKIT_REQUIRED=always
inherit kde4-base

DESCRIPTION="A word translator for KDE"
HOMEPAGE="http://kde-apps.org/content/show.php/QTrans?content=74876"
SRC_URI="http://kde-apps.org/CONTENT/content-files/74876-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS=( ChangeLog README )

src_install() {
	kde4-base_src_install
	rm -f "${ED}"usr/share/apps/qtrans/{ChangeLog,README}
}
