# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/po4a/po4a-0.25.ebuild,v 1.9 2006/10/21 02:00:22 mcummings Exp $

inherit eutils perl-app

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://${PN}.alioth.debian.org"
SRC_URI="mirror://debian/pool/main/p/po4a/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/${PN}_${PV}-1.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh sparc ~x86"
IUSE=""

DEPEND="dev-perl/SGMLSpm
	>=sys-devel/gettext-0.13
	>=dev-perl/module-build-0.28
	app-text/openjade
	dev-perl/Locale-gettext
	dev-perl/TermReadKey
	dev-perl/Text-WrapI18N"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/po4a_0.25-1.patch
}

src_compile() {
	rm "${S}"/Makefile
	perl-app_src_compile
}
