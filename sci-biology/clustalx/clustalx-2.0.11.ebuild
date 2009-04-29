# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalx/clustalx-2.0.11.ebuild,v 1.1 2009/04/29 01:49:57 weaver Exp $

EAPI=2

inherit qt4 eutils

DESCRIPTION="Graphical interface for the ClustalW multiple alignment program"
HOMEPAGE="http://www.ebi.ac.uk/tools/clustalw2/"
SRC_URI="http://www.clustal.org/download/current/${P}.tar.gz"

LICENSE="clustalw"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

RDEPEND=">=sci-biology/clustalw-2.0.11"

src_prepare() {
	sed -e "s|colprot.xml|/usr/share/${PN}/colprot.xml|" \
			-e "s|coldna.xml|/usr/share/${PN}/coldna.xml|" \
			-e "s|colprint.xml|/usr/share/${PN}/colprint.xml|" \
			-i ClustalQtParams.h || \
			die "Failed to patch shared files location."
	sed -e "s|clustalx.hlp|/usr/share/${PN}/clustalx.hlp|" \
			-i HelpDisplayWidget.cpp || \
			die "Failed to patch help file location."
	rm -f moc*.{cpp,o} || die
}

src_compile() {
	eqmake4
	emake || die "Compilation failed."
}

src_install() {
	dobin clustalx || die "Failed to install program."
	insinto "/usr/share/${PN}"
	doins colprot.xml coldna.xml colprint.xml clustalx.hlp || \
			die "Failed to install shared files."
	make_desktop_entry ${PN} ClustalX "" "Application;Science"
}
