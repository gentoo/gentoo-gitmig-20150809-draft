# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mime-data/gnome-mime-data-2.0.0.ebuild,v 1.6 2002/09/21 11:49:09 bjb Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="MIME database for Gnome"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"

RDEPEND=">=dev-libs/glib-2.0.0"

DEPEND="${RDEPEND} 
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"





