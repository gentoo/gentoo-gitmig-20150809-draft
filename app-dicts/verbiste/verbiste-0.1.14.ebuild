# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/verbiste/verbiste-0.1.14.ebuild,v 1.3 2006/05/01 01:01:29 tester Exp $

inherit autotools eutils

DESCRIPTION="French conjugation system"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/verbiste.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~x86"

IUSE="gnome"

DEPEND=">=dev-libs/libxml2-2.4.0
	gnome? ( >=gnome-base/gnome-panel-2.0
		>=gnome-base/libgnomeui-2.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-as-needed.patch"
	AT_M4DIR="${S}/macros" eautoreconf
}

src_compile() {
	econf $(use_with gnome) || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
	dodoc AUTHORS ChangeLog HACKING LISEZMOI NEWS README THANKS TODO
}

