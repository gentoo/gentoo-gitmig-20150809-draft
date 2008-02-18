# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kblogger/kblogger-0.7_beta2.ebuild,v 1.2 2008/02/18 22:34:46 ingmar Exp $

inherit kde versionator

MY_P=${PN}-$(replace_version_separator 2 -)

DESCRIPTION="Blogging applet for KDE"
HOMEPAGE="http://kblogger.pwsp.net/"
SRC_URI="http://kblogger.pwsp.net/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( =kde-base/kdebase-3.5* =kde-base/kicker-3.5* )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/}"

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}
