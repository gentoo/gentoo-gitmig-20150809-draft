# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.20.1.ebuild,v 1.9 2008/04/20 02:10:12 vapier Exp $

WANT_AUTOMAKE="1.9"

inherit virtualx autotools eutils gnome2 python

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc"

#next bump: check if we should activate Xevie or not

RDEPEND=">=dev-libs/atk-1.17
	>=x11-libs/gtk+-2.10.0
	>=gnome-base/gail-1.9.0
	>=gnome-base/libbonobo-1.107
	>=gnome-base/orbit-2
	dev-libs/popt
	>=dev-lang/python-2.4

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1 )

	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/inputproto
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# bug number ?
	epatch "${FILESDIR}"/${PN}-1.19.3-tests.patch

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	# drop gtk-doc for autoreconf
	use doc || epatch "${FILESDIR}/${P}-drop-gtk-doc.patch"

	eautoreconf
}

src_test() {
	Xemake check || die "Testing phase failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/pyatspi
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/pyatspi
}
