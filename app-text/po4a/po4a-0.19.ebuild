# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/po4a/po4a-0.19.ebuild,v 1.1 2005/01/18 12:02:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://${PN}.alioth.debian.org"
SRC_URI="http://alioth.debian.org/download.php/828/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
style="builder"

IUSE=""
KEYWORDS="~x86"

DEPEND=${DEPEND}"
	dev-perl/SGMLSpm
	>=sys-devel/gettext-0.13
	>=dev-perl/module-build-0.25
	app-text/openjade
	dev-perl/Locale-gettext"

src_compile() {
	perl-module_src_compile
	perl ${S}/Build build
}
