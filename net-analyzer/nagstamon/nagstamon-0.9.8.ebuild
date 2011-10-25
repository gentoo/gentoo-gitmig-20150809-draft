# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagstamon/nagstamon-0.9.8.ebuild,v 1.1 2011/10/25 22:41:05 idl0r Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit eutils python

MY_P="${PN}_${PV/_/-}"
MY_PN="Nagstamon"

DESCRIPTION="Nagstamon is a Nagios status monitor for a systray and displays a realtime status of a Nagios box"
HOMEPAGE="http://nagstamon.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

DEPEND=""
RDEPEND="dev-python/pygtk
	dev-python/lxml
	dev-python/beautifulsoup
	gnome? ( dev-python/egg-python )"

#S="${WORKDIR}/${MY_P}"
S="${WORKDIR}/Nagstamon"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.5-resources.patch"

	python_convert_shebangs 2 nagstamon.py

	rm Nagstamon/resources/LICENSE
	rm Nagstamon/BeautifulSoup.py
}

src_install() {
	# setup.py is broken
	cd Nagstamon/

	doman resources/nagstamon.1 || die
	rm resources/nagstamon.1

	nagstamon_install() {
		exeinto $(python_get_sitedir)/${MY_PN}
		doexe ../nagstamon.py || die
		dosym $(python_get_sitedir)/${MY_PN}/${PN}.py /usr/bin/${PN} || die

		insinto $(python_get_sitedir)/${MY_PN}
		doins {GUI,Config,Objects,Custom,Actions}.py || die
		touch "${D}/$(python_get_sitedir)/${MY_PN}/__init__.py" || die
		doins -r Server/ || die

		insinto /usr/share/${PN}/resources
		doins resources/* || die

		insinto /usr/share/applications
		doins "${FILESDIR}"/${PN}.desktop || die
	}

	python_execute_function nagstamon_install
}

pkg_postinst() {
	python_mod_optimize ${MY_PN}
}

pkg_postrm() {
	python_mod_cleanup ${MY_PN}
}
