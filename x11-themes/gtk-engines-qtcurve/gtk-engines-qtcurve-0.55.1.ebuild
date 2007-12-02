# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qtcurve/gtk-engines-qtcurve-0.55.1.ebuild,v 1.1 2007/12/02 18:10:43 drac Exp $

inherit cmake-utils eutils

MY_P=${P/gtk-engines-qtcurve/QtCurve-Gtk2}

DESCRIPTION="A set of widget styles for GTK2 based apps, also available for KDE3 and Qt4"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mozilla"

RDEPEND=">=x11-libs/gtk+-2
	x11-libs/cairo"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4"

S=${WORKDIR}/${MY_P}

src_compile() {
	local mycmakeargs="-DQTC_ADD_EVENT_FILTER=true"
	use mozilla && mycmakeargs="-DQTC_MODIFY_MOZILLA=true"
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog README TODO
}
