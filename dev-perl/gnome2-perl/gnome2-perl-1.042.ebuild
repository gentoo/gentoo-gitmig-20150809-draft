# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-1.042.ebuild,v 1.2 2010/07/20 15:17:41 jer Exp $

MODULE_AUTHOR=TSCH
inherit perl-module

DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries"
HOMEPAGE="http://gtk2-perl.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtk2-perl/Gnome2-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/Gnome2-${PV}

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeprint-2
	>=dev-perl/gtk2-perl-1.0
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	>=dev-perl/gnome2-canvas-1.0
	>=dev-perl/glib-perl-1.04
	>=dev-perl/gnome2-vfs-perl-1.0
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.2
	>=dev-perl/extutils-pkgconfig-1.03"

SRC_TEST=do
