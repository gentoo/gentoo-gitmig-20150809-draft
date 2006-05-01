# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mercurial/mercurial-0.8.1.ebuild,v 1.2 2006/05/01 00:32:17 weeve Exp $

inherit bash-completion distutils

MY_PV=${PV//_p/.}

DESCRIPTION="scalable distributed SCM"
HOMEPAGE="http://www.selenic.com/mercurial/"
SRC_URI="http://www.selenic.com/mercurial/release/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	app-text/asciidoc
	app-text/xmlto"

if [[ ${PV} == *_p* ]]; then
	S=${WORKDIR}/mercurial-snapshot
else
	S=${WORKDIR}/${PN}-${MY_PV}
fi

src_compile() {
	distutils_src_compile

	cd doc
	local x
	for x in *.?.txt; do
		asciidoc -d manpage -b docbook $x || die
		xmlto man ${x%txt}xml || die
		sed -nie '/./p' ${x%.*} || die
	done
}

src_install() {
	distutils_src_install

	dobashcompletion contrib/bash_completion ${PN}

	dodoc CONTRIBUTORS PKG-INFO README *.txt
	cp hgweb*.cgi ${D}/usr/share/doc/${PF}/
	cp -r contrib ${D}/usr/share/doc/${PF}/
	doman doc/*.?
}

pkg_postinst() {
	distutils_pkg_postinst
	bash-completion_pkg_postinst
}
