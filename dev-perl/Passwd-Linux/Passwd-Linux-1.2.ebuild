# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Passwd-Linux/Passwd-Linux-1.2.ebuild,v 1.1 2007/10/19 19:45:53 ian Exp $

inherit perl-module

DESCRIPTION="Perl module for manipulating the passwd and shadow files"
HOMEPAGE="http://search.cpan.org/~eestabroo/Passwd-Linux-${PV}/Linux.pm"
SRC_URI="mirror://cpan/authors/id/E/EE/EESTABROO/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
