# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Kakasi/Text-Kakasi-2.04.ebuild,v 1.8 2004/07/14 20:44:56 agriffis Exp $

inherit perl-module eutils

DESCRIPTION="This module provides libkakasi interface for Perl."
HOMEPAGE="http://search.cpan.org/dist/Text-Kakasi/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DA/DANKOGAI/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

DEPEND=">=app-i18n/kakasi-2.3.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Text-Kakasi-1.05-gentoo.diff
}
