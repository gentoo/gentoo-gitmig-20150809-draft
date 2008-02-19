# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-0.9.3.ebuild,v 1.9 2008/02/19 12:04:08 ingmar Exp $

inherit kde

MY_P=${P/_/-}

DESCRIPTION="Client for the NUT UPS monitoring daemon"
HOMEPAGE="http://www.knut.noveradsl.cz/knutclient/"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/${PN}/stable/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

need-kde 3.5

PATCHES="${FILESDIR}/${P}-xdg_desktop_entry.diff"

S="${WORKDIR}"/${MY_P}

src_unpack(){
	kde_src_unpack
	# assure we pick up the patch
	rm "${S}"/configure

	sed -e 's/.png//' -i "${S}"/src/${PN}.desktop || die 'Sed failed'
}
