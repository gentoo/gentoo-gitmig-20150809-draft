# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WordNet-QueryData/WordNet-QueryData-1.49.ebuild,v 1.2 2010/02/15 03:33:23 robbat2 Exp $

EAPI="2"

MODULE_AUTHOR="JRENNIE"

inherit perl-module

DESCRIPTION="direct perl interface to WordNet database"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-dicts/wordnet"
RDEPEND="${DEPEND}"

src_configure() {
	export WNHOME=/usr
	perl-module_src_configure
}
