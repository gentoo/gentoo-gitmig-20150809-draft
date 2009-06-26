# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gourmet/gourmet-0.13.8.ebuild,v 1.1 2009/06/26 03:47:34 nixphoeni Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Simple but powerful recipe-managing application"
HOMEPAGE="http://grecipe-manager.sourceforge.net/"
SRC_URI="mirror://sourceforge/grecipe-manager/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-print rtf"

RDEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.3.93
	>=dev-python/libgnome-python-2
	>=gnome-base/libglade-2
	|| ( >=dev-lang/python-2.5[sqlite]
	     >=dev-python/pysqlite-2 )
	dev-python/imaging
	dev-python/reportlab
	dev-db/metakit[python]
	rtf? ( dev-python/pyrtf )
	gnome-print? (	>=gnome-base/libgnomeprint-2
			>=dev-python/libgnomeprint-python-2 )"
DEPEND="${RDEPEND}"

DOCS="README TODO PKG-INFO CHANGES"

src_prepare() {
	epatch "${FILESDIR}/${PN}-python-2.6-threading.patch"
}

src_install() {
	distutils_src_install --disable-modules-check
}
