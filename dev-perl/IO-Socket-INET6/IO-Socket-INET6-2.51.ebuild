# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-INET6/IO-Socket-INET6-2.51.ebuild,v 1.12 2006/04/09 17:55:19 vapier Exp $

inherit perl-module

DESCRIPTION="Work with IO sockets in ipv6"
HOMEPAGE="http://search.cpan.org/~mondejar/${P}"
SRC_URI="mirror://cpan/authors/id/M/MO/MONDEJAR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="dev-perl/Socket6"

SRC_TEST="do"
