# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xtrs/xtrs-4.9-r1.ebuild,v 1.2 2006/07/22 09:07:14 dertobi123 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="RadioShack TRS80 Emulator, inc. FreeWare ROM & LDOS Image"
HOMEPAGE="http://www.tim-mann.org/trs80.html"
SRC_URI="http://home.gwi.net/~plemon/sources/${P}.tar.gz
	 http://home.gwi.net/~plemon/support/disks/xtrs/ld4-631.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/readline
	|| ( ( >=x11-libs/libX11-1.0.0 )
	virtual/x11 )"

src_unpack() {
	### make doesn't play nicely with the usual ${PREFIX} behaviour, but relies
	### on an external Makefile.local to set compiletime options, and default
	### behavious.  we'll patch it here, to make our install sane.
	unpack ${P}.tar.gz
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
}

src_compile() {
	use ppc && echo "ENDIAN = -Dbig_endian" >> Makefile.local
	emake DEBUG="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/xtrs/disks /usr/share/man/man1
	make install || die "make install failed"
	dodoc README xtrsrom4p.README

	#  OSS rom images & an lsdos image
	tar \
		-C "${D}"/usr/share/xtrs/ \
		--no-same-owner \
		-zxvf "${DISTDIR}/ld4-631.tar.gz"  || die "tar failed"
}
