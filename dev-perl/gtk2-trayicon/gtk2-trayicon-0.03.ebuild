# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-trayicon/gtk2-trayicon-0.03.ebuild,v 1.1 2004/03/06 02:43:12 pyrania Exp $

inherit perl-module

MY_P=Gtk2-TrayIcon-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl wrappers for the egg cup Gtk2::TrayIcon utilities."
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="${DEPEND}
	>=x11-libs/gtk+-2*
	>=gnome-base/libglade-2*
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig"
