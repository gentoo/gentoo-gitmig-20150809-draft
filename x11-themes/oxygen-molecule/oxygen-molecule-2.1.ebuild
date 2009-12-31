# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/oxygen-molecule/oxygen-molecule-2.1.ebuild,v 1.2 2009/12/31 14:35:21 ssuominen Exp $

MY_PN=Oxygen-Molecule

DESCRIPTION="Unified KDE and GTK+ theme"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=103741"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/103741-${MY_PN}_${PV}_theme.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="kde-base/oxygen-icons
	x11-themes/gtk-engines
	x11-themes/gtk-engines-murrine"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	tar -xzf kde43-${PN}.tar.gz || die
	find "${WORKDIR}" -name .directory -delete
}

src_install() {
	insinto /usr/share/themes
	doins -r kde43-${PN} || die
	insinto /usr/share/${PN}
	doins *.colors || die
	insinto /usr/share/doc/${PF}/pdf
	doins *.pdf || die
	insinto /usr/share/doc/${PF}/odt
	doins *.odt || die
}
