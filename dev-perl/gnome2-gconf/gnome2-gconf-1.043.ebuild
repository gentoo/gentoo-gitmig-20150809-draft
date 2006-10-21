# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-gconf/gnome2-gconf-1.043.ebuild,v 1.1 2006/10/21 16:54:10 mcummings Exp $

inherit perl-module

MY_P=Gnome2-GConf-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl wrappers for the GConf configuration engine."
SRC_URI="mirror://cpan/authors/id/E/EB/EBASSI/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rmcfarla/${MY_P}/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""


DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=dev-perl/glib-perl-1.120
	>=dev-perl/gtk2-perl-1.120
	>=dev-perl/extutils-pkgconfig-1.03
	>=dev-perl/extutils-depends-0.202
	dev-lang/perl"
