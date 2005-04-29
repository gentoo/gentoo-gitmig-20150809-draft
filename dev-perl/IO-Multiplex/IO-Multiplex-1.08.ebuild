# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Multiplex/IO-Multiplex-1.08.ebuild,v 1.2 2005/04/29 08:12:07 ticho Exp $

inherit perl-module

DESCRIPTION="Manage IO on many file handles "
HOMEPAGE="http://search.cpan.org/~HOME/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BB/BBB/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

SRC_TEST="do"
