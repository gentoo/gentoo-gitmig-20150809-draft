# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-vfs-perl/gnome2-vfs-perl-1.061.ebuild,v 1.12 2012/03/31 12:06:26 armin76 Exp $

inherit perl-module

MY_P=Gnome2-VFS-${PV}

DESCRIPTION="Perl interface to the 2.x series of the Gnome Virtual File System libraries."
HOMEPAGE="http://search.cpan.org/~tsch/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2
	>=dev-perl/glib-perl-1.120
	>=dev-perl/gtk2-perl-1.02
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.2
	>=dev-perl/extutils-pkgconfig-1.03"

S=${WORKDIR}/${MY_P}
