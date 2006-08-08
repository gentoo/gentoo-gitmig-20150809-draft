# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mercurial/mercurial-0.9.1.ebuild,v 1.2 2006/08/08 20:46:49 agriffis Exp $

inherit bash-completion distutils

MY_PV=${PV//_p/.}

DESCRIPTION="scalable distributed SCM"
HOMEPAGE="http://www.selenic.com/mercurial/"
SRC_URI="http://www.selenic.com/mercurial/release/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.3
	doc? (
		app-text/asciidoc
		app-text/xmlto
	)"

if [[ ${PV} == *_p* ]]; then
	S=${WORKDIR}/mercurial-snapshot
else
	S=${WORKDIR}/${PN}-${MY_PV}
fi

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		local x
		for x in *.?.txt; do
			asciidoc -d manpage -b docbook $x || die
			xmlto man ${x%txt}xml || die
			sed -nie '/./p' ${x%.*} || die
		done
	fi

	rm -rf contrib/vim	# app-vim/hgcommand app-vim/hgmenu
}

src_install() {
	distutils_src_install

	dobashcompletion contrib/bash_completion ${PN}

	dodoc CONTRIBUTORS PKG-INFO README *.txt
	cp hgweb*.cgi ${D}/usr/share/doc/${PF}/
	cp -r contrib ${D}/usr/share/doc/${PF}/
	if use doc; then
		doman doc/*.?
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	bash-completion_pkg_postinst
}
