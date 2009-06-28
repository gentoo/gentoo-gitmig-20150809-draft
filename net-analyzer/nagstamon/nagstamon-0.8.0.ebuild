# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagstamon/nagstamon-0.8.0.ebuild,v 1.1 2009/06/28 08:54:16 dertobi123 Exp $

EAPI="2"

inherit eutils python

MY_P=${P/-/_}

DESCRIPTION="Nagstamon is a Nagios status monitor for a systray and displays a realtime status of a Nagios box."
HOMEPAGE="http://nagstamon.wiki.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

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
	epatch "${FILESDIR}/${P}-sharedir.patch"
}

src_install() {
	exeinto $(python_get_sitedir)/${PN}
	doexe nagstamon.py
	doexe nagstamonActions.py
	doexe nagstamonConfig.py
	doexe nagstamonGUI.py
	doexe nagstamonObjects.py
	dosym $(python_get_sitedir)/${PN}/${PN}.py /usr/bin/${PN}

	dodir /usr/share/${PN}/resources
	insinto /usr/share/${PN}/resources
	doins resources/*

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}
