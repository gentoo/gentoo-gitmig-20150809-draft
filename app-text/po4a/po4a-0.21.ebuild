# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/po4a/po4a-0.21.ebuild,v 1.6 2006/10/20 21:31:56 mcummings Exp $

inherit perl-app

MY_PV=${PV/21/20}
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://${PN}.alioth.debian.org"
SRC_URI="http://alioth.debian.org/download.php/984/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
KEYWORDS="amd64 x86"

DEPEND="${DEPEND}
	dev-perl/SGMLSpm
	>=sys-devel/gettext-0.13
	>=dev-perl/module-build-0.28
	app-text/openjade
	dev-perl/Locale-gettext
	dev-perl/TermReadKey
	dev-perl/Text-WrapI18N"

src_compile() {
	rm ${S}/Makefile
	perl-app_src_compile
}
