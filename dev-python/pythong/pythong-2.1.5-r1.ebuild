# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythong/pythong-2.1.5-r1.ebuild,v 1.1 2008/10/26 23:32:10 hawking Exp $

EAPI="2"
inherit python distutils multilib

MY_PN="pythonG"
MY_PV=${PV/_/-}
MY_PV=${MY_PV//\./_}

DESCRIPTION="Nice and powerful spanish development environment for Python"
SRC_URI="http://www3.uji.es/~dllorens/downloads/pythong/linux/${MY_PN}-${MY_PV}.tgz
	doc? ( http://marmota.act.uji.es/MTP/pdf/python.pdf )"
HOMEPAGE="http://www3.uji.es/~dllorens/PythonG/principal.html"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~x86"
SLOT="0"
IUSE="doc"

S=${WORKDIR}/${MY_PN}-${MY_PV}

RDEPEND=">=dev-lang/python-2.2.2[tk]
	>=dev-lang/tk-8.3.4
	>=dev-python/pmw-1.2"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

PYTHON_MODNAME="libpythong"

src_prepare() {
	default

	python_version

	sed -i \
		-e "s:^\(fullpath = \).*:\1'/usr/$(get_libdir)/python${PYVER}/site-packages/':" \
		-e "/^url_docFuncPG/s:'+fullpath+':/usr/share/doc/${PF}:" \
		pythong.py || die "sed in pythong.py failed"
}

src_compile() {
	:
}

src_install() {
	python_version

	insinto $(python_get_sitedir)
	doins modulepythong.py || die "doins failed"
	doins -r libpythong || die "doins failed"

	exeinto /usr/bin
	doexe pythong.py || die "doexe failed"

	dodoc leeme.txt || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	doins {LICENCIA,MANUAL,demos} || die "doins failed"
	rm -f "${D}"/usr/share/doc/"${PF}"/demos/modulepythong.py

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/python.pdf
	fi
}
