# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple/XML-Simple-1.08.ebuild,v 1.2 2002/05/21 18:14:08 danarmak Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl XML Simple package."
SRC_URI="http://www.cpan.org/authors/id/G/GR/GRANTM/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30"
