# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.9.8-r2.ebuild,v 1.3 2004/11/12 08:22:11 eradicator Exp $

IUSE=""

inherit eutils flag-o-matic gnuconfig

MY_P=${PN}-III-alpha9.8
S=${WORKDIR}/${MY_P}

DESCRIPTION="an advanced CDDA reader with error correction"
HOMEPAGE="http://www.xiph.org/paranoia/"
SRC_URI="http://www.xiph.org/paranoia/download/${MY_P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# cdda_paranoia.h should include cdda_interface_h, else most configure
	# scripts testing for support fails (gnome-vfs, etc).
	epatch ${FILESDIR}/${P}-include-cdda_interface_h.patch
	epatch ${FILESDIR}/${P}-toc.patch
	epatch ${FILESDIR}/${P}-identify_crash.patch
	epatch ${FILESDIR}/${PV}-gcc34.patch

	# if libdir is specified, cdparanoia causes sandbox violations, and using
	# einstall doesnt work around it. so lets patch in DESTDIR support
	epatch ${FILESDIR}/${P}-use-destdir.patch

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
	make DESTDIR=${D} install || die
	dodoc FAQ.txt README
}
