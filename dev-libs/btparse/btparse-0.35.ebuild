# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/btparse/btparse-0.35.ebuild,v 1.2 2007/01/26 05:39:05 beandog Exp $

DESCRIPTION="A C library to parse Bibtex files"
HOMEPAGE="http://www.gerg.ca/software/btOOL/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/A/AM/AMBS/btparse/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
