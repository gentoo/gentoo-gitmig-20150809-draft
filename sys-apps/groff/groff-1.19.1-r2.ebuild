# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.19.1-r2.ebuild,v 1.5 2004/11/04 17:33:49 lv Exp $

inherit eutils flag-o-matic toolchain-funcs

MB_PATCH="groff_1.18.1-7" #"${P/-/_}-7"
DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"
SRC_URI="mirror://gnu/groff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 sparc ~x86"
IUSE="X"

DEPEND="virtual/libc
	>=sys-apps/texinfo-4.7-r1"
PDEPEND=">=sys-apps/man-1.5k-r1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix the info pages to have .info extensions,
	# else they do not get gzipped.
	epatch ${FILESDIR}/groff-1.18-infoext.patch

	# Do not generate example files that require us to
	# depend on netpbm.
	epatch ${FILESDIR}/groff-1.18-no-netpbm-depend.patch

	# Make dashes the same as minus on the keyboard so that you
	# can search for it. Fixes #17580 and #16108
	# Thanks to James Cloos <cloos@jhcloos.com>
	epatch ${FILESDIR}/${PN}-man-UTF-8.diff

	# Fix stack limit (inifite loop) #64117
	epatch ${FILESDIR}/${P}-stack.patch

	# Fix tempfile usage #68404
	epatch ${FILESDIR}/${P}-tmpfile.patch
}

src_compile() {
	local myconf=

	# Fix problems with not finding g++
	export CC="$(tc-getCC)"
	export CXX="$(tc-getCXX)"

	# -Os causes segfaults, -O is probably a fine replacement
	# (fixes bug 36008, 06 Jan 2004 agriffis)
	replace-flags -Os -O

	# -march=2.0 makes groff unable to finish the compile process
	use hppa && replace-cpu-flags 2.0 1.0

#	myconf="${myconf} `use_enable cjk multibyte`"

	# this is incredibly broken, i have no idea why people are trying to use
	# it... even the documentation on it states that -fnew-ra is "meant only
	# for testing. Users should not specify this option, since it is not yet
	# ready for production use."
	filter-flags -fnew-ra

	# many fun sandbox errors with econf
	myconf="${myconf} --host=${CHOST} --prefix=/usr \
		--mandir=/usr/share/man --infodir=\${inforoot}"
	./configure ${myconf} || die

	# Parallel build doesn't work. Patched wanted.
	emake -j1 || die

	# Only build X stuff if we have X installed, but do
	# not depend on it, else we get circular deps.
	if use X && [ -x /usr/X11R6/bin/xmkmf ]
	then
		cd ${S}/src/xditview
		xmkmf || die
		make depend all || die
	fi
}

src_install() {
	dodir /usr /usr/share/doc/${PF}/{examples,html}
	make prefix=${D}/usr \
		manroot=${D}/usr/share/man \
		inforoot=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${PF} \
		install || die

	if use X && [ -x /usr/X11R6/bin/xmkmf ]
	then
		cd ${S}/src/xditview
		make DESTDIR=${D} \
			BINDIR=/usr/bin \
			MANPATH=/usr/share/man \
			install \
			install.man || die
	fi

	# The following links are required for xman
	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl
	dosym soelim /usr/bin/zsoelim

	cd ${S}
	dodoc BUG-REPORT ChangeLog FDL MORE.STUFF NEWS \
		PROBLEMS PROJECTS README REVISION TODO VERSION
}
