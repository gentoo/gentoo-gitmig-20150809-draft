# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/domino/domino-0.4.ebuild,v 1.5 2008/01/06 23:51:00 philantrop Exp $

ARTS_REQUIRED="never"
inherit kde

DESCRIPTION="A KDE style with a soft look"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=42804"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/42804-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( kde-base/kwin kde-base/kdebase )"
need-kde 3.4

PATCHES="${FILESDIR}/${P}-fbsd.patch"

src_unpack() {
	kde_src_unpack
	rm -f "${S}/configure"
}
