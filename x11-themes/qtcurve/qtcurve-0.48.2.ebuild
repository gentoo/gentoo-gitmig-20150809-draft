# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve/qtcurve-0.48.2.ebuild,v 1.1 2007/03/24 02:21:13 beandog Exp $

ARTS_REQUIRED="never"
inherit eutils kde
MY_P="${P/qtcurve/QtCurve-KDE3}"
DESCRIPTION="A set of widget styles for KDE based apps, also available for GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://home.freeuk.com/cpdrummond/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
need-kde 3.5
S="${WORKDIR}/${MY_P}"

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog README TODO
}
