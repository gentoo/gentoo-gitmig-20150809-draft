# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ReadBackwards/File-ReadBackwards-1.02.ebuild,v 1.5 2004/12/23 07:39:30 nigoro Exp $

inherit perl-module

DESCRIPTION="The Perl File-ReadBackwards Module"
SRC_URI="http://www.cpan.org/modules/by-module/File/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc alpha ~sparc ~hppa ~ppc64"
SRC_TEST="do"
DEPEND="|| ( dev-perl/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
