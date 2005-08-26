# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-2.1-r1.ebuild,v 1.13 2005/08/26 02:23:43 agriffis Exp $

inherit perl-module

DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="mirror://cpan/authors/id/S/SI/SIMON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

SLOT="0"
DEPEND="dev-perl/MIME-tools
	>=dev-perl/Mail-POP3Client-2.7
	>=dev-perl/MailTools-1.15"
