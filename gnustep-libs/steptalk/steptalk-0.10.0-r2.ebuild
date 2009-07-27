# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/steptalk/steptalk-0.10.0-r2.ebuild,v 1.1 2009/07/27 20:19:41 voyageur Exp $

EAPI=2
inherit gnustep-2

MY_PN="StepTalk"
DESCRIPTION="StepTalk is the official GNUstep scripting framework."
HOMEPAGE="http://www.gnustep.org/experience/StepTalk.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${MY_PN}-${PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="gdl2"

DEPEND="gdl2? ( >=gnustep-libs/gdl2-0.11.0 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gnustep-make-2.patch"
	if use gdl2; then
		# These libraries do not exist anymore
		sed -i -e "s/-lgnustep-db2 -lgnustep-db2control -lgnustep-db2modeler//" \
		Modules/GDL2/GNUmakefile || die "gdl2 compilation sed failed"
	else
		# Do not try to compile the module
		sed -i -e "s/GDL2//" Modules/GNUmakefile || die "gdl2 disabling sed failed"
	fi

}

src_install() {
	gnustep-base_src_install

	if use doc ; then
		egnustep_env
		mkdir -p "${D}"${GNUSTEP_SYSTEM_DOC}/Developer/${MY_PN}
		cp -R Documentation/* "${D}"${GNUSTEP_SYSTEM_DOC}/Developer/${MY_PN}
	fi
}
