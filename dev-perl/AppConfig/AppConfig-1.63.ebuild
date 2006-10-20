# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AppConfig/AppConfig-1.63.ebuild,v 1.8 2006/10/20 18:50:12 kloeri Exp $

inherit perl-module eutils

DESCRIPTION="Perl5 module for reading configuration files and parsing command line arguments."
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/${P}/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
KEYWORDS="alpha amd64 ~ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/File-HomeDir-0.57
	virtual/perl-Test-Simple
	dev-lang/perl"
RDEPEND="${DEPEND}"

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
