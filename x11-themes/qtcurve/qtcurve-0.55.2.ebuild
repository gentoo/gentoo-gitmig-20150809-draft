# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve/qtcurve-0.55.2.ebuild,v 1.1 2008/01/24 18:08:16 nelchael Exp $

ARTS_REQUIRED="never"

# Order is important, so we get src_compile from cmake-utils.
inherit kde qt3 cmake-utils

MY_P=${P/qtcurve/QtCurve-KDE3}

DESCRIPTION="A set of widget styles for KDE based apps, also available for GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/cmake-2.4
	$(qt_min_version 3)"

need-kde 3.5

S="${WORKDIR}/${MY_P}"

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog README TODO
}
