# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/cagibi/cagibi-0.2.0.ebuild,v 1.1 2012/01/10 15:51:43 johu Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Cache/proxy system for the SSDP part of UPnP"
HOMEPAGE="http://frinring.wordpress.com/2010/08/09/cagibi-0-1-1-released-network-kio-slave-freezes-kded-in-4-5-0/"
SRC_URI="mirror://kde/stable/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
"
DEPEND="${RDEPEND}
	dev-util/automoc
"

DOCS=( Changelog README TODO )
