# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.12-r2.ebuild,v 1.11 2004/07/17 05:25:11 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
SRC_URI="ftp://ftp.cwi.nl/pub/aeb/kbd/${P}.tar.gz
	ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/kbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="nls"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

src_unpack() {
	local a

	# Workaround problem on JFS filesystems, see bug 42859
	cd ${WORKDIR}
	for a in ${A}; do
		einfo "Unpacking ${a}"
		gzip -dc ${DISTDIR}/${a} | tar xf -
	done

	cd ${S}
	# Fixes makefile so that it uses the CFLAGS from portage (bug #21320).
	sed -i -e "s:-O2:${CFLAGS}:g" src/Makefile.in

	# Other patches from RH
	epatch ${FILESDIR}/${PN}-1.08-terminal.patch

	# Fixes a problem where loadkeys matches dvorak the dir, and not the
	# .map inside
	epatch ${FILESDIR}/${P}-find-map-fix.patch

	# Sparc have not yet fixed struct kbd_rate to use 'period' and not 'rate'.
	epatch ${FILESDIR}/${P}-kbd_repeat-v2.patch
}

src_compile() {
	local myconf=

	# Non-standard configure script; --disable-nls to
	# disable NLS, nothing to enable it.
	use nls || myconf="--disable-nls"

	# We should not add the prefix to mandir and datadir
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share \
		${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make \
		DESTDIR=${D} \
		DATADIR=${D}/usr/share \
		MANDIR=${D}/usr/share/man \
		install || die

	mv ${D}/usr/bin/setfont ${D}/bin/
	dosym ../../bin/setfont /usr/bin/setfont

	dodoc CHANGES CREDITS README
	dodir /usr/share/doc/${PF}/html
	cp -dR doc/* ${D}/usr/share/doc/${PF}/html/
}
