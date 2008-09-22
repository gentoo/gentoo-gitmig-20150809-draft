# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-traymanager/gtk2-traymanager-0.05.ebuild,v 1.13 2008/09/22 16:14:11 tove Exp $

inherit perl-module

MY_P=Gtk2-TrayManager-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl bindings for EggTrayManager"
SRC_URI="mirror://cpan/authors/id/B/BO/BORUP/${MY_P}.tar.gz"
HOMEPAGE="http://gtk2-perl.sf.net/"
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=dev-perl/glib-perl-1.012
	>=dev-perl/gtk2-perl-1.012
	dev-lang/perl"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	dev-util/pkgconfig"
