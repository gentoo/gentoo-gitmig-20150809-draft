# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ReadBackwards/File-ReadBackwards-1.02.ebuild,v 1.1 2003/12/23 00:24:18 rac Exp $

inherit perl-module

DESCRIPTION="The Perl File-ReadBackwards Module"
SRC_URI="http://www.cpan.org/modules/by-module/File/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc ~hppa"
SRC_TEST="do"
newdepend "|| ( dev-perl/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
