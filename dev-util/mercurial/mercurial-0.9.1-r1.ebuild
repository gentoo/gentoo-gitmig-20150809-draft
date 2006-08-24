# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mercurial/mercurial-0.9.1-r1.ebuild,v 1.1 2006/08/24 01:48:11 aross Exp $

inherit bash-completion distutils

MY_PV=${PV//_p/.}

DESCRIPTION="scalable distributed SCM"
HOMEPAGE="http://www.selenic.com/mercurial/"
SRC_URI="http://www.selenic.com/mercurial/release/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="${PN} hgext"

if [[ ${PV} == *_p* ]]; then
	S=${WORKDIR}/mercurial-snapshot
else
	S=${WORKDIR}/${PN}-${MY_PV}
fi

src_compile() {
	distutils_src_compile

	rm -rf contrib/vim	# app-vim/hgcommand app-vim/hgmenu
	rm -rf contrib/{win32,macosx}
}

src_install() {
	distutils_src_install

	dobashcompletion contrib/bash_completion ${PN}

	dodoc CONTRIBUTORS PKG-INFO README *.txt
	cp hgweb*.cgi ${D}/usr/share/doc/${PF}/
	rm -f contrib/bash_completion
	cp -r contrib ${D}/usr/share/doc/${PF}/
	doman doc/*.?
}

pkg_postinst() {
	distutils_pkg_postinst
	bash-completion_pkg_postinst
}
