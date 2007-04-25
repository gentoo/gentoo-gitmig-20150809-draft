# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Passwd-Linux/Passwd-Linux-0.70.ebuild,v 1.1 2007/04/25 15:21:14 ian Exp $

inherit perl-module

DESCRIPTION="Perl module for manipulating the passwd and shadow files"
HOMEPAGE="http://search.cpan.org/~eestabroo/Passwd-Linux-${PV}/Linux.pm"
SRC_URI="mirror://cpan/authors/id/E/EE/EESTABROO/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
