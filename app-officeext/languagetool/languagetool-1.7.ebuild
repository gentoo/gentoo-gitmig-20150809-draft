# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/languagetool/languagetool-1.7.ebuild,v 1.1 2012/05/09 07:23:52 scarabeus Exp $

EAPI=4

MY_P="LanguageTool-${PV}"

OO_EXTENSIONS=(
	"${MY_P}.oxt"
)

inherit office-ext

DESCRIPTION="Style and Grammar Checker for libreoffice"
HOMEPAGE="http://www.languagetool.org/"
SRC_URI="http://www.languagetool.org/download/${MY_P}.oxt"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	virtual/ooo[java]
"

S=${WORKDIR}

src_unpack() {
	cp -v "${DISTDIR}/${MY_P}.oxt" "${S}"
}

pkg_postinst() {
	office-ext_pkg_postinst
	einfo "Be warned that this extension is serious resource hog and thus"
	einfo "it might result in slower operations."
}
