# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/pyfa/pyfa-1.0.6.ebuild,v 1.1 2011/11/02 23:59:34 tetromino Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite threads"

inherit eutils python

if [[ ${PV/_rc*/} == ${PV} ]] ; then
	MY_PV=${PV}-incarna-src
	FOLDER=stable/${PV}
else
	MY_PV=${PV/_rc/-stable-RC}-src
	FOLDER=stable/${PV/*_rc/RC}
fi

DESCRIPTION="Python Fitting Assistant - a ship fitting application for EVE Online"
HOMEPAGE="http://www.evefit.org/Pyfa"
SRC_URI="http://dl.evefit.org/${FOLDER}/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-3 LGPL-2.1 CCPL-Attribution-2.5 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+graph"

RDEPEND="dev-python/sqlalchemy
	>=dev-python/wxpython-2.8
	graph? ( dev-python/matplotlib[wxwidgets] dev-python/numpy )"
DEPEND=""

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# make staticPath settable from configforced again
	epatch "${FILESDIR}/${PN}-1.0.3-staticPath.patch"

	python_convert_shebangs -r -x 2 .
	sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
		-e "s:%%EPREFIX%%:${EPREFIX}:" \
		"${FILESDIR}/configforced.py" > configforced.py
}

src_install() {
	local packagedir=$(python_get_sitedir)/${PN}
	insinto "${packagedir}"
	doins -r eos gui icons service config*.py info.py gpl.txt
	exeinto "${packagedir}"
	doexe ${PN}.py
	dosym "${packagedir}/${PN}.py" /usr/bin/${PN}
	insinto /usr/share/${PN}
	doins -r staticdata
	dodoc readme.txt
	doicon icons/${PN}.png
	domenu "${FILESDIR}/${PN}.desktop"
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
