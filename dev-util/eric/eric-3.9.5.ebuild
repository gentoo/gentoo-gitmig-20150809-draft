# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-3.9.5.ebuild,v 1.1 2007/06/23 12:29:09 dev-zero Exp $

NEED_PYTHON=2.3

inherit python eutils multilib

DESCRIPTION="eric3 is a full featured Python IDE that is written in PyQt using the QScintilla editor widget"
HOMEPAGE="http://www.die-offenbachs.de/detlev/eric3.html"
SRC_URI="mirror://sourceforge/eric-ide/${P}.tar.gz
	linguas_de? ( mirror://sourceforge/eric-ide/${PN}-i18n-de-${PV}.tar.gz )
	linguas_fr? ( mirror://sourceforge/eric-ide/${PN}-i18n-fr-${PV}.tar.gz )
	linguas_ru? ( mirror://sourceforge/eric-ide/${PN}-i18n-ru-${PV}.tar.gz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="idl"

DEPEND=">=dev-python/PyQt-3.13
	>=dev-python/pyxml-0.8.4
	>=dev-python/qscintilla-1.0"
RDEPEND="${DEPEND}
	idl? ( !sparc? ( >=net-misc/omniORB-4.0.3 ) )"

LANGS="de fr ru"


src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-disable_compilation.patch"
}

src_install() {
	python_version

cat >> gentoo_config.py <<- _EOF_

cfg = {
	'ericDir': r"/usr/$(get_libdir)/python${PYVER}/site-packages/eric3",
	'ericPixDir': r"/usr/share/eric3/pixmaps",
	'ericIconDir': r"/usr/share/eric3/icons",
	'ericDTDDir': r"/usr/share/eric3/DTDs",
	'ericCSSDir': r"/usr/share/eric3/CSSs",
	'ericDocDir': r"/usr/share/doc/${PF}/Documentation",
	'ericExamplesDir': r"/usr/share/doc/${PF}/Examples",
	'ericTranslationsDir': r"/usr/share/eric3/i18n",
	'ericWizardsDir': r"/usr/$(get_libdir)/python${PYVER}/site-packages/Wizards",
	'ericTemplatesDir': r"/usr/share/eric3/DesignerTemplates",
	'ericOthersDir': r"/usr/lib/python2.4/site-packages/eric3",
	'bindir': r"/usr/bin",
	'mdir': r"/usr/$(get_libdir)/python${PYVER}/site-packages"
}
_EOF_


	${python} install.py \
		-f "gentoo_config.py" \
		-b "${ROOT}usr/bin" \
		-i "${D}" \
		-d "${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages" \
		-c || die "${python} install.py failed"

	dodoc ChangeLog THANKS eric/README*
	make_desktop_entry "eric3 --nosplash" \
			eric3 \
			"${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/eric3/icons/default/eric.png" \
			"Development;IDE;Qt"
}

pkg_postinst() {
	elog "If you want to use eric3 with mod_python, have a look at"
	elog "  \"${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/eric3/patch_modpython.py\"."

	python_version
	python_mod_optimize "/usr/$(get_libdir)/python${PYVER}/site-packages/eric3"
}

pkg_postrm() {
	python_version
	python_mod_cleanup "/usr/$(get_libdir)/python${PYVER}/site-packages/eric3"
}
