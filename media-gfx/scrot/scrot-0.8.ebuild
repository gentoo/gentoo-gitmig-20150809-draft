# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/scrot/scrot-0.8.ebuild,v 1.14 2005/01/08 00:16:24 vapier Exp $

inherit bash-completion

DESCRIPTION="Screen Shooter"
HOMEPAGE="http://www.linuxbrit.co.uk/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/imlib2-1.0.3
	>=media-libs/giblib-1.2.3"

src_install() {
	make DESTDIR="${D}" install || die
	rm -r "${D}"/usr/doc

	dodoc TODO README AUTHORS ChangeLog

	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}
}
