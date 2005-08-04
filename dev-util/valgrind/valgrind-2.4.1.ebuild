# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.4.1.ebuild,v 1.1 2005/08/04 21:38:19 griffon26 Exp $

inherit eutils flag-o-matic

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux and ppc-GNU/Linux"
HOMEPAGE="http://www.valgrind.org"
SRC_URI="http://www.valgrind.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="X"

# bug #49147 (bogus stacktrace in gdb with --db-attach=yes) does not seem to be applicable anymore
#RESTRICT="strip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# make sure our CFLAGS are respected
	einfo "Changing configure to respect CFLAGS"
	sed -i -e 's:CFLAGS="-Wno-long-long":CFLAGS="$CFLAGS -Wno-long-long":' configure

	# Enables valgrind to build with PIE and disables PIE for 
	# tests that fail to build with it
	epatch "${FILESDIR}/valgrind-2.4.0-pie-fix.patch"

	epatch "${FILESDIR}/${P}-dont-trample-cflags.patch"
	epatch "${FILESDIR}/${P}-static-const.patch"
}

src_compile() {
	local myconf

	# -fomit-frame-pointer	"Assembler messages: Error: junk `8' after expression" 
	#                       while compiling insn_sse.c in none/tests/x86
	# -fstack-protector     ???
	# -ggdb3                segmentation fault on startup
	filter-flags -fomit-frame-pointer
	#filter-flags -fstack-protector
	replace-flags -ggdb3 -ggdb2

	# Optionally build in X suppression files
	use X && myconf="--with-x" || myconf="--with-x=no"

	# Enable this, otherwise when built with PIE it exits at startup
	# with: "executable range is outside acceptable range"
	myconf="${myconf} --enable-pie"

	econf ${myconf} || die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {
	einstall docdir="${D}/usr/share/doc/${PF}/html" || die
	dodoc ACKNOWLEDGEMENTS AUTHORS FAQ.txt NEWS README* TODO
}

