# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-POP3Client/Mail-POP3Client-2.16.ebuild,v 1.4 2004/09/29 10:54:55 mcummings Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="POP3 client module for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703"

mydoc="FAQ"
