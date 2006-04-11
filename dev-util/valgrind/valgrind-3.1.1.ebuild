# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-3.1.1.ebuild,v 1.2 2006/04/11 04:56:06 tsunam Exp $

inherit eutils flag-o-matic

DESCRIPTION="An open-source memory debugger for GNU/Linux"
HOMEPAGE="http://www.valgrind.org"
SRC_URI="http://www.valgrind.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc x86"
IUSE="X"

# bug #49147 (bogus stacktrace in gdb with --db-attach=yes) does not seem to be applicable anymore
#RESTRICT="strip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# make sure our CFLAGS are respected
	einfo "Changing configure.in to respect CFLAGS"
	sed -i -e 's:^CFLAGS="-Wno-long-long":CFLAGS="$CFLAGS -Wno-long-long":' configure.in

	# undefined references to __guard and __stack_smash_handler in VEX (bug #114347)
	einfo "Changing Makefile.flags.am to disable SSP"
	sed -i -e 's:^AM_CFLAGS_BASE = :AM_CFLAGS_BASE = -fno-stack-protector :' Makefile.flags.am

	# Correct hard coded doc location
	sed -i -e "s:doc/valgrind/:doc/${P}/:" docs/Makefile.am

	einfo "Regenerating autotools files..."
	autoconf || die "autoconf failed"
	automake || die "automake failed"

	# fix for amd64 no-multilib profile till valgrind 3.2.0 is out (bug #114407)
	use amd64 && (has_multilib_profile || epatch "${FILESDIR}/valgrind-3.1.0-amd64-nomultilib-fix.patch")
}

src_compile() {
	local myconf

	# -fomit-frame-pointer	"Assembler messages: Error: junk `8' after expression"
	#                       while compiling insn_sse.c in none/tests/x86
	# -fpie                 valgrind seemingly hangs when built with pie on
	#                       amd64 (bug #102157)
	# -fstack-protector     more undefined references to __guard and __stack_smash_handler 
	#                       because valgrind doesn't link to glibc (bug #114347)
	# -ggdb3                segmentation fault on startup
	filter-flags -fomit-frame-pointer
	filter-flags -fpie
	filter-flags -fstack-protector
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

