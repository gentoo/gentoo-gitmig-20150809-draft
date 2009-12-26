# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-DateParse/DateTime-Format-DateParse-0.04-r1.ebuild,v 1.1 2009/12/26 06:41:03 tove Exp $

EAPI=2

MODULE_AUTHOR=JHOBLITT
inherit perl-module

DESCRIPTION="Parses Date::Parse compatible formats"
SRC_URI="${SRC_URI}
	ftp://cpan.cpantesters.org/CPAN/authors/id/A/AN/ANDK/patches/${P}-ANDK-01.patch.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/DateTime-0.29
	dev-perl/DateTime-TimeZone
	dev-perl/TimeDate"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
PATCHES=( "${DISTDIR}/"DateTime-Format-DateParse-0.04-ANDK-01.patch.gz )

src_unpack() {
	unpack ${P}.tar.gz
}
