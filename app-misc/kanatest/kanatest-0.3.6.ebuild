# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kanatest/kanatest-0.3.6.ebuild,v 1.5 2004/12/04 20:46:41 corsair Exp $

DESCRIPTION="Visual flashcard tool for memorizing the Japanese Hiragana and Katakana alphabet"
HOMEPAGE="http://clay.ll.pl/kanatest.html"

SRC_URI="http://clay.ll.pl/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 amd64 ~ppc64"
IUSE=""
DEPEND=">=x11-libs/gtk+-2.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
