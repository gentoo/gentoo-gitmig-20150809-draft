# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-POP3Client/Mail-POP3Client-2.17.ebuild,v 1.6 2006/01/31 21:27:04 agriffis Exp $

inherit perl-module

DESCRIPTION="POP3 client module for Perl"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"
SRC_URI="mirror://cpan/authors/id/S/SD/SDOWD/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ppc s390 sh sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=perl-core/libnet-1.0703"

mydoc="FAQ"
