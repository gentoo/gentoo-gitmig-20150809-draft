# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-vfs-perl/gnome2-vfs-perl-1.021.ebuild,v 1.3 2005/08/26 02:44:27 agriffis Exp $

inherit perl-module

MY_P=Gnome2-VFS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome  VIrtual File System libraries."
HOMEPAGE="http://search.cpan.org/~tsch/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/extutils-depends-0.2
	dev-perl/extutils-pkgconfig
	>=gnome-base/gnome-vfs-2
	>=dev-perl/glib-perl-1.06
	>=dev-perl/gtk2-perl-1.02"
