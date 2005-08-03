# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdome2/gdome2-0.8.1-r1.ebuild,v 1.3 2005/08/03 22:36:13 kloeri Exp $

inherit gnome2

DESCRIPTION="The DOM C library for the GNOME project"
HOMEPAGE="http://gdome2.cs.unibo.it/"
SRC_URI="http://gdome2.cs.unibo.it/tarball/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"
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
}
