# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmsg/wmmsg-1.0.ebuild,v 1.12 2008/01/12 00:38:39 coldwind Exp $

DESCRIPTION="a dockapp that informs of new events, such as incoming chat messages, by displaying related icons and arrival times"
HOMEPAGE="http://swapspace.net/~matt/wmmsg/"
SRC_URI="http://swapspace.net/~matt/wmmsg/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/imlib2
	x11-libs/libXpm"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	einstall || die "Installation failed."
	dodoc AUTHORS README Changelog
	insinto /usr/share/doc/${PF}
	doins wmmsgrc
}
