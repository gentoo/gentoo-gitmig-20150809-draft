# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-chdir/File-chdir-0.06.ebuild,v 1.1 2005/07/17 23:46:09 mcummings Exp $

inherit perl-module

DESCRIPTION="An alternative to File::Spec and CWD"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

SRC_TEST="do"
