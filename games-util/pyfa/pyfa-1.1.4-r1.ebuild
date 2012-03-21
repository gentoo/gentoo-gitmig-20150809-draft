# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/pyfa/pyfa-1.1.4-r1.ebuild,v 1.1 2012/03/21 22:45:57 tetromino Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite threads"

inherit eutils gnome2-utils python

if [[ ${PV/_rc*/} == ${PV} ]] ; then
	MY_PV=${PV}-crucible-src
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
	dev-python/wxpython:2.8
	graph? ( dev-python/matplotlib[wxwidgets] dev-python/numpy )"
DEPEND=""

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# make staticPath settable from configforced again
	epatch "${FILESDIR}/${PN}-1.1-staticPath.patch"

	# use correct slot of wxpython, http://trac.evefit.org/ticket/475
	epatch "${FILESDIR}/${PN}-1.1.4-wxversion.patch"

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
	insinto /usr/share/icons/hicolor/32x32/apps
	doins icons/pyfa.png
	insinto /usr/share/icons/hicolor/64x64/apps
	newins icons/pyfa64.png pyfa.png
	domenu "${FILESDIR}/${PN}.desktop"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	python_mod_optimize ${PN}
}

pkg_postrm() {
	gnome2_icon_cache_update
	python_mod_cleanup ${PN}
}
