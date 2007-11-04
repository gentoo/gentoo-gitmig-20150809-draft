# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kblogger/kblogger-0.7_beta2.ebuild,v 1.1 2007/11/04 14:53:16 philantrop Exp $

inherit kde

MY_P="${P/_/-}"

DESCRIPTION="Blogging applet for KDE"
HOMEPAGE="http://kblogger.pwsp.net/"
SRC_URI="http://kblogger.pwsp.net/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( kde-base/kdebase kde-base/kicker )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/}"

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}
