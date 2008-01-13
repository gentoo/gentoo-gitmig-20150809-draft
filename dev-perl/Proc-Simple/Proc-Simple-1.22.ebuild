# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-Simple/Proc-Simple-1.22.ebuild,v 1.4 2008/01/13 21:43:46 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Perl Proc-Simple -  Launch and control background processes."
HOMEPAGE="http://search.cpan.org/~mschilli/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHILLI/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
