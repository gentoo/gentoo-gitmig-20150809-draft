# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Valid/Email-Valid-0.14.ebuild,v 1.5 2004/05/26 08:37:20 kloeri Exp $

inherit perl-module

DESCRIPTION="Check validity of Internet email addresses."
SRC_URI="http://www.cpan.org/modules/by-module/Email/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/EMail/${P}.readme"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc alpha ~sparc"
LICENSE="GPL-2 | Artistic"
IUSE=""
DEPEND="${DEPEND}
	dev-perl/MailTools
	dev-perl/Net-DNS"
