# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Procmail/Mail-Procmail-1.05.ebuild,v 1.3 2004/01/21 14:21:51 gustavoz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"

DEPEND="${DEPEND}
	dev-perl/Getopt-Long
	>=dev-perl/MailTools-1.15
	>=dev-perl/LockFile-Simple-0.2.5"
