# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagstamon/nagstamon-0.9.3.ebuild,v 1.3 2011/02/12 14:48:05 arfrever Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit eutils python

MY_P=${P/-/_}

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
	gnome? ( || ( dev-python/gnome-python-extras dev-python/egg-python ) )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.0-sharedir.patch"

	python_convert_shebangs 2 Nagstamon/nagstamon
}

src_install() {
	# setup.py is broken
	cd Nagstamon/

	doman resources/nagstamon.1 || die
	rm resources/{LICENSE,nagstamon.1}

	nagstamon_install() {
		exeinto $(python_get_sitedir)/${PN}
		doexe nagstamon || die
		dosym $(python_get_sitedir)/${PN}/${PN} /usr/bin/${PN} || die

		insinto $(python_get_sitedir)/${PN}
		doins nagstamonActions.py || die
		doins nagstamonConfig.py || die
		doins nagstamonGUI.py || die
		doins nagstamonObjects.py || die

		insinto /usr/share/${PN}/resources
		doins resources/* || die

		insinto /usr/share/applications
		doins "${FILESDIR}"/${PN}.desktop || die
	}

	python_execute_function nagstamon_install
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
