# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POP3Client/POP3Client-2.7-r1.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $


inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="POP3 client module for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

DEPEND="${DEPEND}
        >=dev-perl/libnet-1.0703"

mydoc="FAQ"
