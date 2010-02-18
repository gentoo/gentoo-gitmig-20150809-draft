# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagstamon/nagstamon-0.9.1.ebuild,v 1.1 2010/02/18 20:56:40 idl0r Exp $

EAPI="2"

inherit eutils python

MY_P=${P/-/_}

DESCRIPTION="Nagstamon is a Nagios status monitor for a systray and displays a realtime status of a Nagios box."
HOMEPAGE="http://nagstamon.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

DEPEND=""
RDEPEND=">=dev-lang/python-2.4
	dev-python/pygtk
	dev-python/lxml
	gnome? ( || ( dev-python/gnome-python-extras dev-python/egg-python ) )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.0-sharedir.patch"
}

src_install() {
	cd "${S}/Nagstamon/"
	exeinto $(python_get_sitedir)/${PN}
	doexe nagstamon
	doexe nagstamonActions.py
	doexe nagstamonConfig.py
	doexe nagstamonGUI.py
	doexe nagstamonObjects.py
	dosym $(python_get_sitedir)/${PN}/${PN} /usr/bin/${PN}

	dodir /usr/share/${PN}/resources
	insinto /usr/share/${PN}/resources
	doins resources/*

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}
