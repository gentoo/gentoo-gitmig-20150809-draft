# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-3.9.3.ebuild,v 1.2 2006/12/30 00:19:42 dev-zero Exp $

inherit python eutils

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
RDEPEND=">=dev-python/PyQt-3.13
	>=dev-python/pyxml-0.8.4
	idl? ( !sparc? ( >=net-misc/omniORB-4.0.3 ) )"

LANGS="de fr ru"

python_version

src_install() {
	python install.py \
		-b "${ROOT}usr/bin" \
		-i "${D}" \
		-d "${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages" \
		-c || die "python install.py failed"

	dodoc HISTORY THANKS eric/README*
	make_desktop_entry "eric3 --nosplash" \
			eric3 \
			"${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/eric3/icons/default/eric.png" \
			"Development;IDE;Qt"
}

pkg_postinst() {
	elog "If you want to use eric3 with mod_python, have a look at"
	elog "\"${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/eric3/patch_modpython.py\"."
}
