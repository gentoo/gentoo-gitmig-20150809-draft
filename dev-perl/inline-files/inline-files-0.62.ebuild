# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/inline-files/inline-files-0.62.ebuild,v 1.7 2004/10/16 23:57:25 rac Exp $

inherit perl-module

MY_P=Inline-Files-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Multiple virtual files in a single file"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DC/DCONWAY/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/DCONWAY/${MY_P}"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"

KEYWORDS="x86 ~sparc alpha ppc"
IUSE=""
