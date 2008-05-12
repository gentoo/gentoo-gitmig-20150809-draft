# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-4.0.4.ebuild,v 1.6 2008/05/12 15:15:13 corsair Exp $

NEED_PYTHON=2.4

inherit python eutils

MY_PN=${PN}4
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

IUSE="linguas_de linguas_fr linguas_ru"

DESCRIPTION="eric4 is a full featured Python IDE that is written in PyQt4 using the QScintilla editor widget"
HOMEPAGE="http://www.die-offenbachs.de/detlev/eric4.html"
SRC_URI="mirror://sourceforge/eric-ide/${MY_P}.tar.gz
	linguas_de? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-de-${PV}.tar.gz )
	linguas_fr? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-fr-${PV}.tar.gz )
	linguas_ru? ( mirror://sourceforge/eric-ide/${MY_PN}-i18n-ru-${PV}.tar.gz )"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"

DEPEND=">=dev-python/PyQt4-4.1
	>=dev-python/qscintilla-python-2.1
	>=x11-libs/qt-4.2.0"
RDEPEND="${DEPEND}"

LANGS="de fr ru"

python_version

pkg_setup() {
	if ! built_with_use 'dev-python/qscintilla-python' 'qt4'; then
		eerror "Please build qscintilla-python with qt4 useflag."
		die "qscintilla-python built without qt4."
	fi
}

src_install() {
	# Change qt dir to be located in ${D}
	dodir /usr/share/qt4/
	sed -i \
		-e "s:pyqtconfig._pkg_config\[\"qt_data_dir\"\]:\"${D}/usr/share/qt4/\":" \
		install.py

	${python} install.py \
		-b "/usr/bin" \
		-i "${D}" \
		-d "/usr/$(get_libdir)/python${PYVER}/site-packages" \
		-c || die "python install.py failed"

	dodir /usr/share/qt4/qsci/api/python/
	dodoc THANKS eric/README*
	make_desktop_entry "eric4 --nosplash" \
			eric4 \
			"/usr/$(get_libdir)/python${PYVER}/site-packages/eric4/icons/default/eric.png" \
			"Development;IDE;Qt"
}

pkg_postinst() {
	elog "If you want to use eric4 with mod_python, have a look at"
	elog "\"${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/eric4/patch_modpython.py\"."
	elog
	elog "The following packages will give eric extended functionality."
	elog
	elog "dev-python/pylint"
	elog "dev-python/pysvn            (NOT YET IN PORTAGE)"
	elog "dev-python/cx_freeze        (NOT YET IN PORTAGE)"
}
