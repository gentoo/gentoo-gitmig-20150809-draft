# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-2.1-r1.ebuild,v 1.6 2003/10/06 12:53:19 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="2"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

SLOT="0"
DEPEND="${DEPEND}
	dev-perl/MIME-tools
	>=dev-perl/POP3Client-2.7
	>=dev-perl/MailTools-1.15"
