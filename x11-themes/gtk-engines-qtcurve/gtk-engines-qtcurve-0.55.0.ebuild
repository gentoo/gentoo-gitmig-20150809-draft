# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qtcurve/gtk-engines-qtcurve-0.55.0.ebuild,v 1.1 2007/10/17 14:27:54 beandog Exp $

inherit eutils

MY_P="${P/gtk-engines-qtcurve/QtCurve-Gtk2}"
DESCRIPTION="A set of widget styles for GTK2 based apps, also available for KDE3 and Qt4"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mozilla"
DEPEND=">=dev-util/cmake-2.4.0
	x11-libs/cairo
	>=x11-libs/gtk+-2.0"
S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf=
	mkdir "${S}/build"
	cd "${S}/build"
	use mozilla && myconf="-DQTC_MODIFY_MOZILLA=true"
	cmake .. -DQTC_ADD_EVENT_FILTER=true ${myconf} || die "cmake failed"
}

src_install () {
	cd "${S}/build"
	emake DESTDIR="${D}" install || die "make install failed"
	cd "${S}"
	dodoc ChangeLog README TODO
}
