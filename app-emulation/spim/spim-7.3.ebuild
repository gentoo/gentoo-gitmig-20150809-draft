# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spim/spim-7.3.ebuild,v 1.4 2006/12/19 21:41:35 drizzt Exp $

inherit eutils toolchain-funcs

DESCRIPTION="MIPS Simulator"
HOMEPAGE="http://www.cs.wisc.edu/~larus/spim.html"
SRC_URI="http://www.cs.wisc.edu/~larus/SPIM/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc-macos ~sparc x86"
IUSE="X"

RDEPEND="X? ( || ( ( x11-libs/libXaw x11-libs/libXp ) virtual/x11 ) )"
DEPEND="${RDEPEND}
		X? ( || ( ( x11-misc/imake x11-proto/xproto ) virtual/x11 ) )
		>=sys-apps/sed-4
		sys-devel/bison"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix documentation files
	cd ${S}/Documentation
	mv spim.man spim.1
	mv xspim.man xspim.1
}

src_compile() {
	cd ${S}/spim

	./Configure || die "Configure Failed!"

	sed -i \
		-e 's:@make:@$(MAKE):' \
		-e 's:\(BIN_DIR = \).*$:\1\$(DESTDIR)/usr/bin:' \
		-e 's:\(MAN_DIR = \).*$:\1\$(DESTDIR)/usr/share/man:' \
		-e 's:\(EXCEPTION_DIR = \).*$:\1$(DESTDIR)/var/lib/spim:' \
		-e 's:\(^\W*install.*\) exceptions.s \(.*$\):\1 \$(CPU_DIR)/exceptions.s \2:' \
		-e "s:^\W*install.* spim.man .*$::" \
		-e "s:tail -2:tail -n2:" \
		Makefile

	emake CC="$(tc-getCC)" || die

	if use X ; then
		cd ${S}/xspim

		./Configure || die "Configure Failed!"

		xmkmf || die

		sed -i \
			-e 's:@make:@$(MAKE):' \
			-e "s:\(BIN_DIR = \).*$:\1/usr/bin:" \
			-e "s:\(MAN_DIR = \).*$:\1/usr/share/man:" \
			-e "s:\(EXCEPTION_DIR = \).*$:\1/var/lib/spim:" \
			Makefile

		emake CC="$(tc-getCC)" -j1 xspim || die
	fi
}

src_test() {
	cd ${S}/spim
	make test || die "Failed to pass tests!"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man
	dodir /var/lib/spim

	cd ${S}/spim
	make install DESTDIR="${D}" || die "Unable to install spim"

	if use X ; then
		cd ${S}/xspim
		make DESTDIR="${D}" install || die "Unable to install xspim"
	fi

	cd ${S}/Documentation
	doman spim.1
	use X && doman xspim.1

	dohtml SPIM.html
	dodoc BLURB

	cd ${S}
	dodoc README VERSION ChangeLog
}
