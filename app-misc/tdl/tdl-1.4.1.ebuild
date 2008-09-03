# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tdl/tdl-1.4.1.ebuild,v 1.16 2008/09/03 08:51:22 opfer Exp $

DESCRIPTION="Command line To Do List manager"
HOMEPAGE="http://www.rc0.org.uk/tdl/"
SRC_URI="http://www.rrbcurnow.freeuk.com/tdl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc"
IUSE="doc readline"

RDEPEND="
	readline? (
		>=sys-libs/readline-4.3
		sys-libs/ncurses
	)"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	>=sys-apps/sed-4
	doc? ( virtual/texi2dvi )"

src_compile() {
	local myconf="--prefix=/usr"

	if ! use readline; then
		myconf="${myconf} --without-readline"
	else
		sed -i 's#-ltermcap#-lncurses#g' "${S}"/configure
	fi

	./configure ${myconf} || die "configure failed, sorry!"
	emake all tdl.info tdl.html tdl.txt || die
	use doc && emake tdl.dvi tdl.ps tdl.pdf
}

src_install() {
	local i

	dodoc README NEWS tdl.txt "${FILESDIR}/screenshot.png"
	doinfo tdl.info
	dohtml tdl.html

	dobin tdl
	doman tdl.1

	for i in tdl{a,l,d,g}
	do
		dosym tdl /usr/bin/${i}
		dosym tdl.1 /usr/share/man/man1/${i}.1
	done

	use doc && dodoc tdl.dvi tdl.ps tdl.pdf
}
