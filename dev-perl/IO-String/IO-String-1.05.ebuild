# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-String/IO-String-1.05.ebuild,v 1.7 2005/03/12 10:57:51 corsair Exp $

inherit perl-module

DESCRIPTION="IO::File interface for in-core strings"
SRC_URI="http://www.cpan.org/modules/by-module/IO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ppc ~sparc ~alpha ppc64 mips"
IUSE=""

SRC_TEST="do"
