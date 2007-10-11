# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/minised/minised-1.11.ebuild,v 1.1 2007/10/11 05:34:46 vapier Exp $

inherit eutils

DESCRIPTION="a smaller, cheaper, faster SED implementation"
HOMEPAGE="http://www.exactcode.de/oss/minised/"
SRC_URI="http://dl.exactcode.de/oss/minised/minised-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-{build,headers}.patch
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc BUGS README
}
