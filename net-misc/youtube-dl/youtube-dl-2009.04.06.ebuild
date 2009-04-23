# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2009.04.06.ebuild,v 1.1 2009/04/23 15:09:49 patrick Exp $

EAPI="2"

DESCRIPTION="A small command-line program to download videos from YouTube."
HOMEPAGE="http://bitbucket.org/rg3/youtube-dl/"
SRC_URI="http://bitbucket.org/rg3/${PN}/get/${PV}.bz2 -> ${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_unpack() {
	:
}

src_install() {
	newbin "${DISTDIR}/${P}" ${PN}
}
