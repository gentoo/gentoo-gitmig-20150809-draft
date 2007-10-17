# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve/qtcurve-0.55.0.ebuild,v 1.1 2007/10/17 14:22:41 beandog Exp $

ARTS_REQUIRED="never"
inherit eutils kde
MY_P="${P/qtcurve/QtCurve-KDE3}"
DESCRIPTION="A set of widget styles for KDE based apps, also available for GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-util/cmake-2.4.0"

IUSE=""
need-kde 3.5
S="${WORKDIR}/${MY_P}"

src_compile() {
	mkdir "${S}/build"
	cd "${S}/build"
	cmake .. || die "cmake failed"
	make || die "make failed"
}

src_install () {
	cd "${S}/build"
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${S}"
	dodoc ChangeLog README TODO
}
