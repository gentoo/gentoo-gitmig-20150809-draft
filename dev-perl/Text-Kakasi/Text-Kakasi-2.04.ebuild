# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Kakasi/Text-Kakasi-2.04.ebuild,v 1.1 2003/06/20 16:46:03 yakina Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="This module provides libkakasi interface for Perl."
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DA/DANKOGAI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Text-Kakasi/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=">=app-text/kakasi-2.3.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILEDIR}/Text-Kakasi-1.05-gentoo.diff
}
