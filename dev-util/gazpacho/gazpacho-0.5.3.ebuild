# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gazpacho/gazpacho-0.5.3.ebuild,v 1.1 2005/04/18 19:45:49 pythonhead Exp $

inherit distutils

MY_P=Gazpacho-${PV}

DESCRIPTION="Gazpacho is a glade-like gtk interface designer."
HOMEPAGE="http://gazpacho.sicem.biz/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/0.5/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pygtk-2.4
	>=gnome-base/libglade-2.4.2"

S=${WORKDIR}/${MY_P}
DOCS="AUTHORS NEWS"

src_install() {
	distutils_src_install
	dodoc doc/*
}
