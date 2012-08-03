# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-spell/gtk2-spell-1.40.0.ebuild,v 1.3 2012/08/03 11:00:14 ago Exp $

EAPI=4

MY_PN=Gtk2-Spell
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Bindings for GtkSpell with Gtk2.x"
HOMEPAGE="http://gtk2-perl.sf.net/ ${HOMEPAGE}"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND="
	x11-libs/gtk+:2
	>=app-text/gtkspell-2:2
	>=dev-perl/glib-perl-1.240.0
	>=dev-perl/gtk2-perl-1.012
"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	virtual/pkgconfig
"
