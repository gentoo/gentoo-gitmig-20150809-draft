# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Storable/Storable-2.07-r1.ebuild,v 1.1 2003/07/26 19:19:16 rac Exp $

inherit perl-module

DESCRIPTION="The Perl Storable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Storable/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~alpha sparc hppa"

newdepend "|| ( dev-perl/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
