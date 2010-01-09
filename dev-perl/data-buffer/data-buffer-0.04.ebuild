# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/data-buffer/data-buffer-0.04.ebuild,v 1.20 2010/01/09 19:47:29 grobian Exp $

inherit perl-module

MY_P=Data-Buffer-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Read/write buffer class"
HOMEPAGE="http://search.cpan.org/~btrott/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-lang/perl"
