# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-1.8.ebuild,v 1.10 2002/08/16 02:49:00 murphy Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="1"
LICENSE="Artistic"
KEYWORDS="x86 sparc sparc64"

SLOT="0"
DEPEND="${DEPEND}
	>=dev-perl/POP3Client-2.7
	>=dev-perl/MailTools-1.15"
