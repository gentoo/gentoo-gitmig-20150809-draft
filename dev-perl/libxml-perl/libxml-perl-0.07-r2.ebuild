# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libxml-perl/libxml-perl-0.07-r2.ebuild,v 1.6 2004/02/16 23:02:55 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Collection of Perl modules for working with XML"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ia64"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29"
