# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagstamon/nagstamon-0.6.2.ebuild,v 1.1 2008/12/05 14:21:42 dertobi123 Exp $

EAPI="2"

inherit eutils python

MY_P="${PN}_${PV}"

DESCRIPTION="Nagstamon is a Nagios status monitor for a systray and displays a realtime status of a Nagios box."
HOMEPAGE="http://nagstamon.wiki.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.4
	dev-python/pygtk
	dev-python/gnome-python-extras
	dev-python/lxml"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-sharedir.patch"
}

src_install() {
	insinto $(python_get_sitedir)/${PN}
	insopts -m 0755
	doins nagstamon.py

	dodir /usr/share/nagstamon
	cp -a resources "${D}"/usr/share/nagstamon

	dosym $(python_get_sitedir)/${PN}/${PN}.py /usr/bin/${PN}
}
