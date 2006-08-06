# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-0.58.ebuild,v 1.5 2006/08/06 00:58:49 nigoro Exp $

inherit perl-module

DESCRIPTION="Get home directory for self or other user"
HOMEPAGE="http://search.cpan.org/~adamk/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
