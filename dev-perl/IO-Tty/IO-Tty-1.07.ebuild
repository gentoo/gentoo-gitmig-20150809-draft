# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tty/IO-Tty-1.07.ebuild,v 1.7 2006/12/24 00:29:54 dertobi123 Exp $

inherit perl-module

DESCRIPTION="IO::Tty and IO::Pty modules for Perl"
HOMEPAGE="http://search.cpan.org/~rgiersig/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RG/RGIERSIG/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc s390 sh sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

mymake="/usr"
