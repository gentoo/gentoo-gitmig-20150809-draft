# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Grove/XML-Grove-0.46_alpha-r1.ebuild,v 1.4 2003/06/21 21:36:44 drobbins Exp $

inherit perl-module

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module providing a simple API to parsed XML instances"
HOMEPAGE="http://cpan.org/modules/by-module/XML/${MY_P}.readme"
SRC_URI="http://cpan.org/modules/by-module/XML/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 ppc"

DEPEND="${DEPEND}
	>=libxml-perl-0.07-r1"
