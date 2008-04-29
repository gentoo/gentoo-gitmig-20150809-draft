# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-0.69.ebuild,v 1.1 2008/04/29 04:55:53 yuval Exp $

inherit perl-module

DESCRIPTION="Get home directory for self or other user"
HOMEPAGE="http://search.cpan.org/~adamk/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

#SRC_TEST="do"

DEPEND="virtual/perl-File-Spec
        dev-lang/perl"
