# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tdl/tdl-1.5.2.ebuild,v 1.9 2004/10/05 13:34:52 pvdabeel Exp $

inherit eutils flag-o-matic

DESCRIPTION="Command line To Do List manager"
HOMEPAGE="http://www.rc0.org.uk/tdl/"
SRC_URI="http://www.rpcurnow.force9.co.uk/tdl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc ~amd64"
IUSE="readline ncurses doc"

RDEPEND=">=sys-libs/readline-4.3
	ncurses? ( sys-libs/ncurses )
	!ncurses? ( sys-libs/libtermcap-compat )"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	>=sys-apps/sed-4
	doc? ( virtual/tetex )"

src_compile() {
	local myconf="--prefix=/usr"

	if ! use readline; then
		myconf="${myconf} --without-readline"

		if use ncurses; then
			sed -i 's#\($(LIB_READLINE)\)#\1 -lncurses##g' ${S}/Makefile.in
		else
			sed -i 's#\($(LIB_READLINE)\)#\1 -ltermcap##g' ${S}/Makefile.in
		fi
	fi

	if use ncurses; then
		sed -i 's#-ltermcap#-lncurses#g' ${S}/configure
	else
		sed -i 's#-lncurses##g' ${S}/configure
	fi

	./configure ${myconf} || die "configure failed, sorry!"
	emake all tdl.info tdl.html tdl.txt || die
	use doc && emake tdl.dvi tdl.ps tdl.pdf
}

src_install() {
	local i

	dodoc README NEWS tdl.txt ${FILESDIR}/screenshot.png
	doinfo tdl.info
	dohtml tdl.html

	dobin tdl
	doman tdl.1

	for i in tdl{a,l,d,g}
	do
		dosym tdl /usr/bin/${i}
		dosym tdl.1 /usr/share/man/man1/${i}.1
	done

	prepallman

	use doc && dodoc tdl.dvi tdl.ps tdl.pdf
}
