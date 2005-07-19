# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/verbiste/verbiste-0.1.11.ebuild,v 1.2 2005/07/19 03:08:54 tester Exp $

DESCRIPTION="French conjugation system"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/verbiste.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64"

IUSE="gnome"

DEPEND="dev-libs/libxml2
	gnome? ( >=gnome-base/gnome-panel-2.0
		>=gnome-base/libgnomeui-2.0 )"

src_compile() {
	cd ${S}

	econf $(use_with gnome) || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
	dodoc AUTHORS ChangeLog HACKING LISEZMOI NEWS README THANKS TODO
}

