# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-ASN1/Convert-ASN1-0.17.ebuild,v 1.1 2003/06/07 11:35:52 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Standard en/decode of ASN.1 structures"
SRC_URI="http://cpan.pair.com/modules/by-module/Convert/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Convert/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
