# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XPath/XML-XPath-1.12.ebuild,v 1.2 2002/05/21 18:14:08 danarmak Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A XPath Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30"
