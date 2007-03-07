# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/klineakconfig/klineakconfig-0.9.0_pre2.ebuild,v 1.4 2007/03/07 13:26:07 genstef Exp $

ARTS_REQUIRED="never"

inherit kde

MY_P=${P/_/-}

DESCRIPTION="LinEAK KDE configuration frontend"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="x11-misc/lineakd"

S="${WORKDIR}/${MY_P}"

need-kde 3.4

src_unpack() {
	unpack ${A}
	rm -rf "${S}/admin" "${S}/configure"
	ln -s "${WORKDIR}/admin" "${S}/admin"
}
