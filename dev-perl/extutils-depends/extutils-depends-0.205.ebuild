# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-depends/extutils-depends-0.205.ebuild,v 1.5 2005/03/27 14:28:05 kloeri Exp $

inherit perl-module

MY_P=ExtUtils-Depends-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Easily build XS extensions that depend on XS extensions"
HOMEPAGE="http://search.cpan.org/~rmcfarla${MY_P}"
SRC_URI="mirror://cpan/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~ppc ~ppc64 s390 sparc x86"
IUSE=""
