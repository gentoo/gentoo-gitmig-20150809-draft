# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/diacanvas/diacanvas-0.15.4.ebuild,v 1.1 2008/11/24 13:25:36 eva Exp $

inherit eutils gnome2

MY_P=${PN}2_${PV}
MY_P2=${PN}2-${PV}

DESCRIPTION="Gnome library to draw diagrams"
HOMEPAGE="http://diacanvas.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

IUSE="python gnome doc"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="LGPL-2.1"

RDEPEND=">=dev-libs/glib-2
	>=media-libs/libart_lgpl-2
	>=gnome-base/libgnomecanvas-2
	python? (
		>=dev-lang/python-2.2
		>=dev-python/pygtk-2 )
	gnome? ( >=gnome-base/libgnomeprint-2.2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.7 )"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

S="${WORKDIR}/${MY_P2}"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable gnome gnome-print)
		$(use_enable python)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix functions overridden more than once
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1783924&group_id=21360&atid=371905
	epatch "${FILESDIR}/${P}-python-bindings.patch"
}
