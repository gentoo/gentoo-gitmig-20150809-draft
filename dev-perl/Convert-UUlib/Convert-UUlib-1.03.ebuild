# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-UUlib/Convert-UUlib-1.03.ebuild,v 1.4 2005/02/06 18:19:24 corsair Exp $

inherit perl-module

DESCRIPTION="A Perl interface to the uulib library"
SRC_URI="http://www.cpan.org/modules/by-module/Convert/MLEHMANN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Convert/MLEHMANN/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~ppc64"
IUSE=""

SRC_TEST="do"
