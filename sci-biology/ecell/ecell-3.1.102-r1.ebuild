# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ecell/ecell-3.1.102-r1.ebuild,v 1.3 2006/09/12 05:15:11 ribosome Exp $

inherit eutils

DESCRIPTION="Software suite for modelling biological cells"
HOMEPAGE="http://ecell.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecell/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc gnome"

RDEPEND="dev-libs/boost
	dev-lang/python
	dev-python/numeric
	sci-libs/gsl
	dev-python/empy
	gnome? ( gnome-base/libglade
		>=dev-python/pygtk-2
		dev-python/gnome-python
		x11-libs/gtk+extra
		dev-python/python-gtkextra )"

DEPEND="${RDEPEND}
	doc? ( media-gfx/graphviz
		app-doc/doxygen
		app-text/docbook-sgml-utils )"

src_compile() {
	local myconf
	use gnome || myconf="--disable-gtk"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	einstall || die
	if use doc; then
		dohtml doc/refman/html || die "HTML docs missing"
	fi
}
