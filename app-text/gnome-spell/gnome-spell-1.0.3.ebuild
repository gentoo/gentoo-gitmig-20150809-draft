# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.3.ebuild,v 1.1 2003/05/07 11:04:51 liquidx Exp $

IUSE=""

inherit gnome.org gnome2 libtool

S="${WORKDIR}/${P}"
DESCRIPTION="Gnome spellchecking component."
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.ximian.com/pub/ximian-evolution-beta/source/${P}.tar.gz"

KEYWORDS="~x86 ~sparc ~ppc ~alpha"
SLOT="1"
LICENSE="GPL-2"

DEPEND=">=gnome-base/libgnomeui-2.2
    >=gnome-base/libbonoboui-2.0
    >=gnome-base/libglade-2.0
    >=gnome-base/libbonobo-2.0
    >=gnome-base/bonobo-activation-2.0
    >=gnome-base/ORBit2-2.0
	virtual/aspell-dict"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-lang/perl-5.6.0"

# the control-center capplet seems to be missing
# so gnome-base/control-center-2.0 dep removed

DOCS="AUTHORS COPYING ChangeLog NEWS README"
SCROLLKEEPER_UPDATE="0"
