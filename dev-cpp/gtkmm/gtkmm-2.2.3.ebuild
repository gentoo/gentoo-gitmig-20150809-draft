# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-2.2.3.ebuild,v 1.1 2003/07/12 17:38:27 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
IUSE=""
DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc"

SLOT="2"

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=dev-libs/libsigc++-1.2
	!=sys-devel/gcc-3.3.0*"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5.6.0
	dev-util/pkgconfig"

DOCS="AUTHORS CHANGES COPYING ChangeLog HACKING PORTING NEWS README TODO"




