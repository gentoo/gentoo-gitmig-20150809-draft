# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tty/IO-Tty-1.02.ebuild,v 1.1 2002/10/25 14:31:12 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="IO::Tty and IO::Pty modules for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/R/RG/RGIERSIG/${P}.readme"
SRC_URI="http://cpan.valueclick.com/authors/id/R/RG/RGIERSIG/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc sparc64 alpha"

mymake="/usr"
