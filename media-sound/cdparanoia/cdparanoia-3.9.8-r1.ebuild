# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.9.8-r1.ebuild,v 1.5 2004/07/16 02:42:48 tgall Exp $

inherit eutils flag-o-matic gnuconfig

MY_P=${PN}-III-alpha9.8
DESCRIPTION="an advanced CDDA reader with error correction"
HOMEPAGE="http://www.xiph.org/paranoia/"
SRC_URI="http://www.xiph.org/paranoia/download/${MY_P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips ppc64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	# cdda_paranoia.h should include cdda_interface_h, else most configure
	# scripts testing for support fails (gnome-vfs, etc).
	epatch ${FILESDIR}/${P}-include-cdda_interface_h.patch
	epatch ${FILESDIR}/${PV}-gcc34.patch
	ln -s configure.guess config.guess
	ln -s configure.sub config.sub
	gnuconfig_update
	rm config.{guess,sub}
}

src_compile() {
	append-flags -I${S}/interface
	econf || die
	make OPT="${CFLAGS}" || die
}

src_install() {
	dodir /usr/{bin,lib,include} /usr/share/man/man1
	make \
		prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		install || die
	dodoc FAQ.txt README
}
