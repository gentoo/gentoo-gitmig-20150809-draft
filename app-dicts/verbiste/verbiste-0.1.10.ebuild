# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/verbiste/verbiste-0.1.10.ebuild,v 1.3 2005/06/17 21:07:41 hansmi Exp $

inherit eutils libtool

DESCRIPTION="French conjugation system"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/verbiste.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"

IUSE="gnome"

DEPEND="dev-libs/libxml2
	gnome? ( >=gnome-base/gnome-panel-2.0
		>=gnome-base/libgnomeui-2.0 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/makefileam-libtool-0.1.10.patch
}

src_compile() {
	cd ${S}

	autoreconf
	libtoolize --copy --force

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

