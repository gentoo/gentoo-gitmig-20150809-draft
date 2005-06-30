# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AppConfig/AppConfig-1.56-r2.ebuild,v 1.10 2005/06/30 11:29:43 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="Perl5 module for reading configuration files and parsing command line arguments."
SRC_URI="mirror://cpan/authors/id/A/AB/ABW/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~abw/${P}/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~amd64 sparc ~alpha ppc ppc64"
IUSE=""

SRC_TEST="do"

DEPEND="perl-core/Test-Simple"

src_unpack() {
	unpack ${A}
	cd ${S}

	# 2004.05.27 rac 
	# this patch, which will be sent upstream, allows [ block ] to
	# work without variables becoming ' block _var'

	epatch ${FILESDIR}/blockwhitespace.patch

	# 2004.05.28 rac
	# this patch, which will be sent upstream, allows customizing the
	# separator between [block] and variable name, instead of having _
	# be hardwired.  this is important when processing constructions
	# where _ is a legal part of either blocks or variable names.

	epatch ${FILESDIR}/blocksep.patch
}
