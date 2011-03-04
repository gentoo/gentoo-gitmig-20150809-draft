# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasmagenericshell/libplasmagenericshell-4.6.1.ebuild,v 1.1 2011/03/04 18:00:20 alexxy Exp $

EAPI=3

KMNAME="kdebase-workspace"
KMMODULE="libs/plasmagenericshell"
inherit kde4-meta

DESCRIPTION="Libraries for the KDE Plasma shell"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug test"

DEPEND="
	$(add_kdebase_dep kephal)
"

RDEPEND="${DEPEND}
	$(add_kdebase_dep libkworkspace)
"

KMSAVELIBS="true"

KMEXTRACTONLY="
	libs/kephal/kephal/
"

src_unpack() {
	use test && KMEXTRACTONLY+=" plasma/desktop/shell/data/"
	kde4-meta_src_unpack
}
