# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ReadBackwards/File-ReadBackwards-1.02.ebuild,v 1.3 2004/05/26 09:25:24 kloeri Exp $

inherit perl-module

DESCRIPTION="The Perl File-ReadBackwards Module"
SRC_URI="http://www.cpan.org/modules/by-module/File/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc alpha ~sparc ~hppa"
SRC_TEST="do"
DEPEND="|| ( dev-perl/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
