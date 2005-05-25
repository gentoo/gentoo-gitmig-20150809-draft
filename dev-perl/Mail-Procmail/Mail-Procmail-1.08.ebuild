# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Procmail/Mail-Procmail-1.08.ebuild,v 1.2 2005/05/25 13:59:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="mirror://cpan/authors/id/J/JV/JV/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="${DEPEND}
	perl-core/Getopt-Long
	>=dev-perl/MailTools-1.15
	>=dev-perl/LockFile-Simple-0.2.5"
