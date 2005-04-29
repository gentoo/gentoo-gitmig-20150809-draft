# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Multiplex/IO-Multiplex-1.08.ebuild,v 1.1 2005/04/29 00:18:54 mcummings Exp $

inherit perl-module

DESCRIPTION="Manage IO on many file handles "
HOMEPAGE="http://search.cpan.org/~HOME/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BB/BBB/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
