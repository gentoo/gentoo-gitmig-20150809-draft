# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tdl/tdl-1.5.2-r1.ebuild,v 1.7 2011/06/13 11:24:01 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Command line To Do List manager"
HOMEPAGE="http://www.rc0.org.uk/tdl/"
SRC_URI="
	http://www.rpcurnow.force9.co.uk/tdl/${P}.tar.gz
	http://dev.gentoo.org/~jlec/distfiles/${PN}-screenshot.png.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="doc readline"

RDEPEND="
	sys-libs/ncurses
	sys-libs/readline"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	sys-apps/sed
	doc? ( virtual/texi2dvi )"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch
}

src_configure() {
	tc-export CC
	local myconf="--prefix=${EPREFIX}/usr"

	if ! use readline; then
		myconf="${myconf} --without-readline"

		sed -i 's#\($(LIB_READLINE)\)#\1 -lncurses##g' "${S}"/Makefile.in
	fi
	sed -i 's#-ltermcap#-lncurses#g' "${S}"/configure || die

	# XXX: do not replace with econf.
	"${S}"/configure ${myconf} || die "configure failed, sorry!"
}

src_compile() {
	emake all tdl.info tdl.html tdl.txt || die
	if use doc; then
		emake tdl.dvi tdl.ps tdl.pdf || die
	fi
}

src_install() {
	local i

	dodoc README NEWS tdl.txt "${WORKDIR}"/screenshot.png || die
	doinfo tdl.info || die
	dohtml tdl.html || die

	dobin tdl || die
	doman tdl.1 || die

	for i in tdl{a,l,d,g}
	do
		dosym tdl /usr/bin/${i} || die
		dosym tdl.1 /usr/share/man/man1/${i}.1 || die
	done

	if use doc; then
		dodoc tdl.dvi tdl.ps tdl.pdf || die
	fi
}
