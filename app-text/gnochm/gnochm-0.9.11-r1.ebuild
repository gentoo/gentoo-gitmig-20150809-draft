# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnochm/gnochm-0.9.11-r1.ebuild,v 1.1 2009/02/08 16:23:47 ford_prefect Exp $

inherit gnome2

DESCRIPTION="GnoCHM is a CHM file viewer that integrates with the GNOME desktop."

HOMEPAGE="http://gnochm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=dev-python/pychm-0.8.4
		=dev-python/pygtk-2*
		>=dev-python/libgnome-python-2.22
		>=dev-python/gconf-python-2.22
		>=dev-python/gtkhtml-python-2.19.1"
DEPEND="${RDEPEND}
		app-text/scrollkeeper
		>=dev-util/intltool-0.21
		>=dev-lang/python-2.2.1"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="--enable-mime-update=no"
}
