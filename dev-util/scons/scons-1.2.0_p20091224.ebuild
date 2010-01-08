# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-1.2.0_p20091224.ebuild,v 1.2 2010/01/08 07:47:30 djc Exp $

EAPI=2

inherit distutils

MY_PV=${PV/_p/.d}

DESCRIPTION="Extensible Python-based build utility"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz
	doc? ( http://www.scons.org/doc/${MY_PV}/PDF/${PN}-user.pdf -> ${P}-user.pdf
		   http://www.scons.org/doc/${MY_PV}/HTML/${PN}-user.html -> ${P}-user.html )"

HOMEPAGE="http://www.scons.org/"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"
DEPEND=">=dev-lang/python-2.5[threads]"
RDEPEND=${DEPEND}
DOCS="RELEASE.txt CHANGES.txt"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/scons-1.2.0-popen.patch
}

src_install () {
	distutils_src_install
	# move man pages from /usr/man to /usr/share/man
	dodir /usr/share
	mv "${D}"/usr/man "${D}"/usr/share
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/${P}-user.{pdf,html}
	fi
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}-${MY_PV}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}-${MY_PV}
}
