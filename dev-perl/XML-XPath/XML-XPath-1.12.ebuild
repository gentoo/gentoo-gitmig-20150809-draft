# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XPath/XML-XPath-1.12.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A XPath Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

SLOT="0"
DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30"
