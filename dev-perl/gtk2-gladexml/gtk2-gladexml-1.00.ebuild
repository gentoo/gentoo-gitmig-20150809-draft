# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-gladexml/gtk2-gladexml-1.00.ebuild,v 1.3 2004/07/14 17:41:33 agriffis Exp $

inherit perl-module

MY_P=Gtk2-GladeXML-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Create user interfaces directly from Glade XML files."
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=gnome-base/libglade-2*
	>=dev-util/glade-2.0.0-r1
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig"
