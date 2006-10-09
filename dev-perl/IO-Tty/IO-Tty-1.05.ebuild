# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tty/IO-Tty-1.05.ebuild,v 1.6 2006/10/09 15:45:30 mcummings Exp $

inherit perl-module

DESCRIPTION="IO::Tty and IO::Pty modules for Perl"
HOMEPAGE="http://search.cpan.org/~rgiersig/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RG/RGIERSIG/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 arm ~ia64 ppc s390 sh sparc ~x86"
IUSE=""

mymake="/usr"


DEPEND="dev-lang/perl"
