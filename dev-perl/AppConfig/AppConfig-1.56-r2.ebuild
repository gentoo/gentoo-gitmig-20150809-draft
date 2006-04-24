# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AppConfig/AppConfig-1.56-r2.ebuild,v 1.16 2006/04/24 15:10:21 flameeyes Exp $

inherit perl-module eutils

DESCRIPTION="Perl5 module for reading configuration files and parsing command line arguments."
SRC_URI="mirror://cpan/authors/id/A/AB/ABW/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~abw/${P}/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple"

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
