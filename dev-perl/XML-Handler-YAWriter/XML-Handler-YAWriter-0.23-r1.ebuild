# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Handler-YAWriter/XML-Handler-YAWriter-0.23-r1.ebuild,v 1.11 2005/04/29 15:57:24 mcummings Exp $

inherit perl-module

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module providing a simple API to parsed XML instances"
HOMEPAGE="http://cpan.org/modules/by-module/XML/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/K/KR/KRAEHE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha ia64"
IUSE=""

DEPEND=">=dev-perl/libxml-perl-0.07-r1"
