# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-ArgvFile/Getopt-ArgvFile-1.10.ebuild,v 1.8 2006/08/07 23:07:23 mcummings Exp $

inherit perl-module

DESCRIPTION="This module is a simple supplement to other option handling modules."
SRC_URI="mirror://cpan/authors/id/J/JS/JSTENZEL/${P}.tgz"
HOMEPAGE="http://search.cpan.org/jstenzel/${P}/"
SLOT="0"
LICENSE="GPL-2"
SRC_TEST="do"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
