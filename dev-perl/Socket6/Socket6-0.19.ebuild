# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket6/Socket6-0.19.ebuild,v 1.8 2006/04/24 05:13:49 kumba Exp $

inherit perl-module

DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"
HOMEPAGE="http://search.cpan.org/author/UMEMOTO/${P}/"
SRC_URI="mirror://cpan/authors/id/U/UM/UMEMOTO/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k mips ~ppc ppc64 s390 sh ~sparc ~x86"
IUSE=""

SRC_TEST="do"
