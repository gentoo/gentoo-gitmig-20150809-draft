# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MailTools/MailTools-1.58.ebuild,v 1.3 2004/01/21 14:18:19 gustavoz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Manipulation of electronic mail addresses"
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703"
