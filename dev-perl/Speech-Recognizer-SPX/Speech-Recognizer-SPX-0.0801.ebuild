# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Speech-Recognizer-SPX/Speech-Recognizer-SPX-0.0801.ebuild,v 1.1 2010/02/15 04:11:54 robbat2 Exp $

EAPI="2"

MODULE_AUTHOR="DJHD"

inherit perl-module

DESCRIPTION="Interface to Sphinx-II speech recognition"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-accessibility/sphinx2"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf="--sphinx-prefix=/usr"
	perl-module_src_configure
}
