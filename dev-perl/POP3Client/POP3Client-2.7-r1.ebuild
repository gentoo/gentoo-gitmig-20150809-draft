# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POP3Client/POP3Client-2.7-r1.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="POP3 client module for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
DEPEND="${DEPEND}
        >=dev-perl/libnet-1.0703"

mydoc="FAQ"
