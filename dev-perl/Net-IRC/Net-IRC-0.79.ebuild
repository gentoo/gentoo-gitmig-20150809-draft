# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.79.ebuild,v 1.6 2012/05/28 17:10:18 armin76 Exp $

EAPI=2
MODULE_AUTHOR="APEIRON"
inherit perl-module

DESCRIPTION="Perl IRC module"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~mips ~ppc x86"
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
