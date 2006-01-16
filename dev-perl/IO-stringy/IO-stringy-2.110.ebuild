# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-stringy/IO-stringy-2.110.ebuild,v 1.8 2006/01/16 10:10:36 vapier Exp $

inherit perl-module

DESCRIPTION="A Perl module for I/O on in-core objects like strings and arrays"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/ERYQ/${P}.readme"
SRC_URI="mirror://cpan/authors/id/D/DS/DSKOLL/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
