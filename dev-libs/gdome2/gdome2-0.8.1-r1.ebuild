# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdome2/gdome2-0.8.1-r1.ebuild,v 1.12 2006/08/17 18:50:20 jer Exp $

inherit gnome2

DESCRIPTION="The DOM C library for the GNOME project"
HOMEPAGE="http://gdome2.cs.unibo.it/"
SRC_URI="http://gdome2.cs.unibo.it/tarball/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.2.0
	>=dev-libs/libxml2-2.4.26"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog INSTALL MAINTAINERS NEWS README*"

src_unpack() {
	unpack ${A}

	cd ${S}
	echo -e '#!/bin/sh\npkg-config gdome2 $*' > gdome-config.in

	# make docs honor DESTDIR
	epatch "${FILESDIR}/${P}-docs-destdir.patch"
	
	# prevent gtk-fixxref from running (will cause sandbox violation)
	cd ${S}/gtk-doc
	sed -e 's:gtkdoc-fixxref:#gtkdoc-fixxref:' -i Makefile.in
}
