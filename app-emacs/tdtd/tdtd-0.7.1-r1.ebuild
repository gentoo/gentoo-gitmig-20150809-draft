# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tdtd/tdtd-0.7.1-r1.ebuild,v 1.5 2007/07/03 09:47:29 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="Emacs Major Mode for SGML and XML DTDs"
HOMEPAGE="http://www.menteith.com/tdtd/"
SRC_URI="http://www.menteith.com/tdtd/data/${PN}${PV//./}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"

DEPEND="app-arch/unzip"

SITEFILE=50tdtd-gentoo.el

S=${WORKDIR}
DOCS="TODO changelog.txt readme.txt tutorial.txt"

src_compile() {
	elisp-comp *.el || die "elisp-comp failed"
}

