# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MailTools/MailTools-1.60.ebuild,v 1.1 2004/02/16 13:30:16 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Manipulation of electronic mail addresses"
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha"
SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703"
