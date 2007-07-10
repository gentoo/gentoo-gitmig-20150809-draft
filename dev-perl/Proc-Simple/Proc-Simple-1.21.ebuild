# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-Simple/Proc-Simple-1.21.ebuild,v 1.13 2007/07/10 23:33:28 mr_bones_ Exp $

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
