# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/optipng/optipng-0.4.5.ebuild,v 1.7 2004/07/14 17:48:53 agriffis Exp $

inherit eutils flag-o-matic

DESCRIPTION="Find the optimal compression settings for your png files"
SRC_URI="http://www.cs.toronto.edu/~cosmin/pngtech/optipng/${P}.tar.gz"
HOMEPAGE="http://www.cs.toronto.edu/~cosmin/pngtech/optipng/"

LICENSE="as-is"

SLOT="0"
KEYWORDS="x86 ~ppc ~alpha"

IUSE="ext-png ext-zlib mmx"

DEPEND="ext-png? ( media-libs/libpng )
	ext-zlib? ( sys-libs/zlib )
	virtual/libc"

src_unpack() {
	unpack ${A}

	# optionally use the system binaries, rather than the bundled
	# patched versions (some archs/configurations require patches 
	# not included here)
	cd ${S}/src; epatch ${FILESDIR}/${PF}-more-makefile-options.diff
}

src_compile() {
	cd ${S}/src

	append-ldflags -lm

	# use libpng's mmx makefile if requested
	if use mmx; then

		# do amd64/ia64 support mmx?
		use x86 || ewarn "mmx flag set, but not on x86?"

		usemmx=1
	else
		usemmx=0
	fi

	# only defined in bundled zlib
	if use ext-zlib || use ext-png; then
		append-flags -DZ_RLE=3
	fi

	export usemmx LDFLAGS

	# some logic to decide which version to build...
	if ! use ext-png; then
		if ! use ext-zlib; then
			# use the included patched zlib/libpng
			einfo "Building ${PN} with bundled libraries..."
			emake -f scripts/Makefile.gcc optipng
		else
			# use the system zlib.
			einfo "Building ${PN} with bundled libpng..."
			emake -f scripts/Makefile.gcc optipng-extzlib
		fi
	else
		if use ext-zlib; then
			# use the system zlib and libpng.
			einfo "Building ${PN} without bundled libraries..."
			emake -f scripts/Makefile.gcc optipng-allext
		else
			# use the system libpng.
			einfo "Building ${PN} with bundled zlib..."
			emake -f scripts/Makefile.gcc optipng-extpng
		fi
	fi

	# some feedback everything went ok...
	echo; ls -l optipng; size optipng
}

src_install() {
	dobin ${S}/src/optipng
	dodoc ${S}/doc/{CAVEAT,DESIGN,FEATURES,HISTORY,LICENSE,README,TODO,USAGE}
	dohtml ${S}/doc/index.html
}

pkg_postinst() {
	if use ext-zlib || use ext-png; then
		ewarn "the ext-zlib and ext-png USE flags are designed for users"
		ewarn "that require special modifications to libpng or zlib."
		ewarn
		ewarn "the bundled libraries are highly optimised specifically"
		ewarn "for use with compressing png files, and should be used if"
		ewarn "possible."
		ewarn
		ewarn "if you set these flags in error, please unset them and"
		ewarn "re-merge ${PN}."
	fi
}
