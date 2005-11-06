# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-3.0.1-r1.ebuild,v 1.1 2005/11/06 14:55:28 griffon26 Exp $

inherit eutils flag-o-matic

DESCRIPTION="An open-source memory debugger for GNU/Linux"
HOMEPAGE="http://www.valgrind.org"
SRC_URI="http://www.valgrind.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="X"

# bug #49147 (bogus stacktrace in gdb with --db-attach=yes) does not seem to be applicable anymore
#RESTRICT="strip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Gets rid of text relocations (bug #111233)
	epatch "${FILESDIR}/${P}-pic-fix.patch"
	aclocal
	automake

	# make sure our CFLAGS are respected
	einfo "Changing configure to respect CFLAGS"
	sed -i -e 's:CFLAGS="-Wno-long-long":CFLAGS="$CFLAGS -Wno-long-long":' configure

	# Correct hard coded doc location
	sed -i -e "s:doc/valgrind/:doc/${P}/:" docs/Makefile.in

	# http://bugs.kde.org/show_bug.cgi?id=112167
	epatch "${FILESDIR}/${P}-mfence.patch"
}

src_compile() {
	local myconf

	# -fomit-frame-pointer	"Assembler messages: Error: junk `8' after expression"
	#                       while compiling insn_sse.c in none/tests/x86
	# -fpie                 valgrind seemingly hangs when built with pie on
	#                       amd64 (bug #102157)
	# -fstack-protector     ???
	# -ggdb3                segmentation fault on startup
	filter-flags -fomit-frame-pointer
	filter-flags -fpie
	#filter-flags -fstack-protector
	replace-flags -ggdb3 -ggdb2

	# Optionally build in X suppression files
	use X && myconf="--with-x" || myconf="--with-x=no"

	econf ${myconf} || die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"
	dodoc ACKNOWLEDGEMENTS AUTHORS FAQ.txt NEWS README*
}

