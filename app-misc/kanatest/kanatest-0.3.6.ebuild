# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kanatest/kanatest-0.3.6.ebuild,v 1.9 2005/10/13 23:34:10 swegener Exp $

DESCRIPTION="Visual flashcard tool for memorizing the Japanese Hiragana and Katakana alphabet"
HOMEPAGE="http://clay.ll.pl/kanatest.html"

SRC_URI="http://clay.ll.pl/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""
RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	einstall || die
}
