# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mime-data/gnome-mime-data-2.2.0.ebuild,v 1.8 2003/09/06 23:51:37 msterret Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="MIME database for Gnome"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc"

RDEPEND="virtual/glibc"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

