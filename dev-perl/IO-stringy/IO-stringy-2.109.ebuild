# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-stringy/IO-stringy-2.109.ebuild,v 1.3 2004/07/14 18:32:09 agriffis Exp $

inherit perl-module

DESCRIPTION="A Perl module for I/O on in-core objects like strings and arrays"
SRC_URI="http://www.cpan.org/modules/by-module/IO/ERYQ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/ERYQ/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~s390"
IUSE=""

SRC_TEST="do"
