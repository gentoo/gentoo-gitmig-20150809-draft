# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tty/IO-Tty-0.04.ebuild,v 1.17 2005/03/14 11:21:19 mcummings Exp $

inherit perl-module

DESCRIPTION="IO::Tty and IO::Pty modules for Perl"
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

mymake="/usr"
