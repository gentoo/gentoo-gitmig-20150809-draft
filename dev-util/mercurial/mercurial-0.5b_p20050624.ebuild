# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mercurial/mercurial-0.5b_p20050624.ebuild,v 1.3 2005/06/25 11:33:12 dholm Exp $

inherit distutils

MY_PV=${PV//_p/.}

DESCRIPTION="fast, lightweight source control management system"
HOMEPAGE="http://www.selenic.com/mercurial/"
SRC_URI="http://www.selenic.com/mercurial/release/${PN}-${MY_PV}.tar.gz"
S=${WORKDIR}/${PN}-${MY_PV}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"
if [[ $MY_PV != $PV ]]; then
	DEPEND="${DEPEND}
		app-text/asciidoc
		app-text/xmlto"
fi

src_compile() {
	distutils_src_compile
	if [[ $MY_PV != $PV ]]; then
		cd doc
		local x
		for x in *.?.txt; do
			asciidoc -d manpage -b docbook $x || die
			xmlto man ${x%txt}xml || die
			sed -nie '/./p' ${x%.*} || die
		done
	fi
}

src_install() {
	distutils_src_install
	dodoc COPYING PKG-INFO README TODO *.txt
	cp -r hgeditor contrib ${D}/usr/share/doc/${PF}/
	doman doc/*.?
}
