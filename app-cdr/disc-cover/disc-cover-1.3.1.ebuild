# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/disc-cover/disc-cover-1.3.1.ebuild,v 1.17 2004/05/31 20:14:54 vapier Exp $

DESCRIPTION="Creates CD-Covers via Latex by fetching cd-info from freedb.org or local file"
HOMEPAGE="http://www.liacs.nl/~jvhemert/disc-cover/"
SRC_URI="http://www.liacs.nl/~jvhemert/disc-cover/download/unstable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=dev-perl/Audio-CD-disc-cover-0.04
	virtual/tetex"

src_compile() {
	pod2man disc-cover > disc-cover.1 || die
}

src_install() {
	dobin disc-cover || die
	doman disc-cover.1

	dodoc AUTHORS CHANGELOG TODO
	docinto freedb
	dodoc freedb/*
	docinto docs
	docinto docs/english
	dodoc docs/english/*
	docinto docs/dutch
	dodoc docs/dutch/*
	docinto docs/german
	dodoc docs/german/*
	docinto docs/spanish
	dodoc docs/spanish/*
}
