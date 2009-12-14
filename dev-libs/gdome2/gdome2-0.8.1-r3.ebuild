# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdome2/gdome2-0.8.1-r3.ebuild,v 1.2 2009/12/14 19:54:51 vostorga Exp $

inherit eutils gnome2 autotools

DESCRIPTION="The DOM C library for the GNOME project"
HOMEPAGE="http://gdome2.cs.unibo.it/"
SRC_URI="http://gdome2.cs.unibo.it/tarball/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.2.0
	>=dev-libs/libxml2-2.4.26"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix broken GLIB_CONFIG in configure.in, see #114542
	epatch "${FILESDIR}/${P}-gdome2-config.patch"

	# make docs honor DESTDIR
	epatch "${FILESDIR}/${P}-docs-destdir.patch"

	# prevent gtk-fixxref from running (will cause sandbox violation)
	sed -i -e 's:gtkdoc-fixxref:#gtkdoc-fixxref:' gtk-doc/Makefile* || die

	eautoconf
}
