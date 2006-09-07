# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Interface/IO-Interface-0.98.ebuild,v 1.2 2006/09/07 17:44:38 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}

DESCRIPTION="Perl extension for access to network card configuration information"
HOMEPAGE="http://search.cpan.org/dist/${P}/"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~sparc ~x86"

SRC_TEST="do"
