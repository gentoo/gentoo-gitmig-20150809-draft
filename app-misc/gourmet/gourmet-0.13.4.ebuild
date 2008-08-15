# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gourmet/gourmet-0.13.4.ebuild,v 1.1 2008/08/15 03:09:28 nixphoeni Exp $

inherit eutils distutils

MY_P="${P}-2"

DESCRIPTION="Simple but powerful recipe-managing application"
HOMEPAGE="http://grecipe-manager.sourceforge.net/"
SRC_URI="mirror://sourceforge/grecipe-manager/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="print rtf"

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.3.93
	=dev-python/gnome-python-2*
	=gnome-base/libglade-2*
	>=dev-python/pysqlite-2.0
	dev-python/imaging
	dev-python/reportlab
	dev-db/metakit
	rtf? ( dev-python/pyrtf )
	print? ( gnome-base/libgnomeprint
		 dev-python/gnome-python-extras )"

DOCS="README TODO PKG-INFO CHANGES"

pkg_setup() {
	if ! built_with_use 'dev-db/metakit' python ; then
		eerror "You need to install metakit with python support. Try:"
		eerror "USE='python' emerge metakit"
		die "python support missing from metakit"
	fi
}

src_install() {
	distutils_src_install --disable-modules-check
}
