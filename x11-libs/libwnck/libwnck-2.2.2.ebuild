# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwnck/libwnck-2.2.2.ebuild,v 1.2 2003/07/04 21:01:41 gmsoft Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A window navigation construction kit"
HOMEPAGE="http://www.gnome.org/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.1"		

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
