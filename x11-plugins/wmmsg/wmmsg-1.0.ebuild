# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmsg/wmmsg-1.0.ebuild,v 1.9 2005/08/07 13:35:20 hansmi Exp $

DESCRIPTION="wmmsg is a dockapp that informs you of new events, such as incoming chat messages, by displaying related icons and arrival times"
HOMEPAGE="http://taxiway.swapspace.net/~matt/wmmsg/"
SRC_URI="http://taxiway.swapspace.net/~matt/wmmsg/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""
DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	media-libs/imlib2"
S=${WORKDIR}/${PN}

src_compile() {
	econf || die "Configuration failed."
	emake || die "Compilation failed."
}

src_install() {
	einstall || die "Installation failed."
	dodoc AUTHORS COPYING INSTALL README Changelog
	insinto /usr/share/doc/${PF}
	doins wmmsgrc
}
