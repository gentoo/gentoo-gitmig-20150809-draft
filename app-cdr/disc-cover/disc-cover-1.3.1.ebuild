# Copyright 2002 Felix Kurth <felix@fkurth.de>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-cdr/disc-cover/disc-cover-1.3.1.ebuild,v 1.8 2002/08/16 02:31:09 murphy Exp $

DESCRIPTION="Creates CD-Covers via Latex by fetching cd-info from freedb.org or local file"
HOMEPAGE="http://www.liacs.nl/~jvhemert/disc-cover/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"

DEPEND=">=dev-perl/Audio-CD-disc-cover-0.04
	>=app-text/tetex-1.0.7-r7"
	
SRC_URI="http://www.liacs.nl/~jvhemert/disc-cover/download/unstable/${P}.tar.gz"

src_compile () {
	pod2man disc-cover > disc-cover.1 || die
}

src_install () {
	into /usr
	dobin disc-cover
	doman disc-cover.1

	dodoc AUTHORS CHANGELOG COPYING TODO
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
