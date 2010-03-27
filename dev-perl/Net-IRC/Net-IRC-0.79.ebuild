# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.79.ebuild,v 1.1 2010/03/27 21:47:02 robbat2 Exp $

MODULE_AUTHOR="APEIRON"
EAPI=2
inherit perl-module

DESCRIPTION="Perl IRC module"

SLOT="0"
LICENSE="Artistic"
# upstream is missing some files from the tarball that are needed.
# Entry.pm, EventQueue.pm
# this is being added to the tree just so we can track it.
KEYWORDS="-*"
#KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

mydoc="TODO"

DEPEND="dev-lang/perl"

src_prepare() {
	# Remove the stdin and warning input required re deprecated.
	sed -i \
		-e '/or die $warning/d' \
		-e '/my $acceptance/,/$acceptance eq $ok/d' \
		"${S}"/Makefile.PL
	perl-module_src_prepare
}
