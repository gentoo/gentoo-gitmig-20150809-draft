# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-0.58.ebuild,v 1.9 2006/10/20 18:49:35 kloeri Exp $

inherit perl-module

DESCRIPTION="Get home directory for self or other user"
HOMEPAGE="http://search.cpan.org/~adamk/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
