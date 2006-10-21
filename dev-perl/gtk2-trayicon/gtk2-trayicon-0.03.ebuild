# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-trayicon/gtk2-trayicon-0.03.ebuild,v 1.13 2006/10/21 09:54:49 omp Exp $

inherit perl-module

MY_P=Gtk2-TrayIcon-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl wrappers for the egg cup Gtk2::TrayIcon utilities."
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	dev-util/pkgconfig"
