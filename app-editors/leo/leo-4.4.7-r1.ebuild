# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leo/leo-4.4.7-r1.ebuild,v 1.1 2008/10/26 23:12:29 hawking Exp $

EAPI=2
inherit python multilib

MY_P="${P}-final"

DESCRIPTION="An outlining editor and literate programming tool."
HOMEPAGE="http://leo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEPEND=">=dev-lang/python-2.3[tk]"
DEPEND="app-arch/unzip
	${COMMON_DEPEND}"
RDEPEND="app-text/silvercity
	${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	# Remove all CVS directories
	find . -iname "CVS" -exec rm -rf {} \; 2>/dev/null
}

src_install() {
	dohtml -r doc/html/* || die "dohtml failed"
	dodoc doc/README.TXT || die "dodoc failed"

	python_version

	insinto "/usr/$(get_libdir)/python${PYVER}/site-packages/leo"
	doins -r config extensions Icons  __init__.py modes plugins scripts src ||\
		die "doins failed"

	cat > leo <<- _EOF_
#!/bin/sh
${python} /usr/$(get_libdir)/python${PYVER}/site-packages/leo/src/leo.py \$@
	_EOF_

	dobin leo || die "dobin failed"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/${PN}
}
