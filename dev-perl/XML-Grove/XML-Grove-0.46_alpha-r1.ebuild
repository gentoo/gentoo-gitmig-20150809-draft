# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Grove/XML-Grove-0.46_alpha-r1.ebuild,v 1.6 2003/12/16 01:24:49 weeve Exp $

inherit perl-module

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module providing a simple API to parsed XML instances"
HOMEPAGE="http://cpan.org/modules/by-module/XML/${MY_P}.readme"
SRC_URI="http://cpan.org/modules/by-module/XML/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"

DEPEND=">=dev-perl/libxml-perl-0.07-r1"
