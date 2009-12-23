# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exporter-Lite/Exporter-Lite-0.02.ebuild,v 1.9 2009/12/23 18:10:35 grobian Exp $

inherit perl-module

DESCRIPTION="Lightweight exporting of variables"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
