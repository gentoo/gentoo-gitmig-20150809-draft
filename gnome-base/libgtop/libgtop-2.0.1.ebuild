# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.0.1.ebuild,v 1.4 2003/03/16 15:19:17 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="library that proivdes top functionality to applications" 
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc alpha"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog  INSTALL LIBGTOP-VERSION NEWS README RELNOTES*"
