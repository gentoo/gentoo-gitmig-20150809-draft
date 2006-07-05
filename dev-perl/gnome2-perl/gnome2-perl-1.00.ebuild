# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-1.00.ebuild,v 1.11 2006/07/05 17:22:09 ian Exp $

inherit perl-module

MY_P=Gnome2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries"
HOMEPAGE="http://search.cpan.org/~rmcfarla/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ppc sparc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeprint-2
	>=dev-perl/gtk2-perl-${PV}
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	>=dev-perl/gnome2-canvas-1.0
	>=dev-perl/extutils-depends-0.2
	>=dev-perl/extutils-pkgconfig-1.03
	>=dev-perl/glib-perl-1.04
	>=dev-perl/gnome2-vfs-perl-1.0"
RDEPEND="${DEPEND}"
