# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Balanced/Text-Balanced-1.95.ebuild,v 1.1 2003/05/31 21:27:44 mcummings Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Extract balanced-delimiter substrings"
SRC_URI="http://www.cpan.org/modules/by-authors/id/D/DC/DCONWAY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/D/DC/DCONWAY/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
