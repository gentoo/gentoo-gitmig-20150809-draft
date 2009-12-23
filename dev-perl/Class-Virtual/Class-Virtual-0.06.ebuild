# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Virtual/Class-Virtual-0.06.ebuild,v 1.6 2009/12/23 17:39:38 grobian Exp $

inherit perl-module

DESCRIPTION="Base class for virtual base classes."
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Class-Data-Inheritable
		dev-perl/Carp-Assert
	dev-lang/perl"
