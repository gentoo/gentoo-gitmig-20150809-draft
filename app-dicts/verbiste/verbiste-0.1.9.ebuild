# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/verbiste/verbiste-0.1.9.ebuild,v 1.4 2004/11/22 05:20:12 tester Exp $

inherit eutils

DESCRIPTION="French conjugation system"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/verbiste.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

IUSE="gnome"

DEPEND="dev-libs/libxml2
	gnome? ( >=gnome-base/gnome-panel-2.0
		>=libgnomeui-2.0 )"

src_compile() {
	cd ${S}
	econf $(use_with gnome) || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
	dodoc AUTHORS ChangeLog HACKING LISEZMOI NEWS README THANKS TODO

	if ! use gnome; then
		rm ${D}/usr/share/applications/verbiste.desktop
	fi
}

