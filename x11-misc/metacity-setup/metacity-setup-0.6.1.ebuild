# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/metacity-setup/metacity-setup-0.6.1.ebuild,v 1.2 2002/08/14 23:44:15 murphy Exp $

inherit gnome2

DESCRIPTION="a setup program for metacity"
HOMEPAGE="http://plastercast.tzo.com/~plastercast/Projects/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="x11-wm/metacity
	=x11-libs/gtk+-2.0*
	=dev-libs/glib-2.0*
	gnome-base/libgnomeui"
RDEPEND="${DEPEND}"
SRC_URI="http://plastercast.tzo.com/~plastercast/Projects/${P}.tar.gz"
S=${WORKDIR}/${P}

DOCS="AUTHORS COPYING  ChangeLog INSTALL NEWS README"

