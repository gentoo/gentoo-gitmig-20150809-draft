# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-2.1.ebuild,v 1.15 2004/02/27 15:55:01 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

SLOT="0"
DEPEND="${DEPEND}
	>=dev-perl/Mail-POP3Client-2.7
	>=dev-perl/MailTools-1.15"
