# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/diction/diction-1.07-r1.ebuild,v 1.5 2006/07/15 13:52:23 grobian Exp $

inherit eutils

DESCRIPTION="Diction and style checkers for english and german texts"
HOMEPAGE="http://www.gnu.org/software/diction/diction.html"
SRC_URI="http://www.moria.de/~michael/diction/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc-macos sparc x86"
IUSE="unicode"

DEPEND="sys-devel/gettext"
RDEPEND="virtual/libintl"

src_unpack() {
	unpack ${A}; cd ${S}

	epatch ${FILESDIR}/${P}-style-fail-on-bad-lang.patch
	if use unicode; then
		iconv -f ISO-8859-1 -t UTF-8 de > de.new || die "charset conversion failed."
		mv de.new de
	fi
}

src_compile() {
	./configure --prefix=/usr ||die
	emake || die
}

src_install() {
	make prefix=${D}/usr install
}
