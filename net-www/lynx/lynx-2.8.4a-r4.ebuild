# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/lynx/lynx-2.8.4a-r4.ebuild,v 1.7 2002/08/29 22:37:21 seemant Exp $

S=${WORKDIR}/lynx2-8-4
DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="http://lynx.browser.org/"
SRC_URI="ftp://lynx.isc.org/lynx2.8.4/lynx2.8.4.tar.bz2"

KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3
	nls? ( sys-devel/gettext )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

PROVIDE="virtual/textbrowser"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/lynx2.8.4rel.1a.patch || die

	# GCC3.1 support -- check if it's really needed in
	# future. Some users report complete success with -r3 --
	# credit to lostlogix and carpaski. Resolves #3172
	cd src
	patch LYStrings.c < ${FILESDIR}/lynx-2.8.4a-LYStrings.c-gentoo.patch || die
}

src_compile() {
	local myconf
	use nls && myconf="${myconf} --enable-nls"
	use ssl && myconf="${myconf} --with-ssl=yes"
	use ipv6 && myconf="${myconf} --enable-ipv6"

	CFLAGS="${CFLAGS} -DANSI_VARARGS"

	econf \
		--libdir=/etc/lynx \
		--enable-cgi-links \
		--enable-prettysrc \
		--enable-nsl-fork \
		--enable-file-upload \
		--enable-read-eta \
		--enable-libjs \
		--enable-color-style \
		--enable-scrollbar \
		--enable-included-msgs \
		--with-zlib \
		${myconf} || die

	emake || die "compile problem"
}

src_install() {
	make prefix=${D}/usr datadir=${D}/usr/share mandir=${D}/usr/share/man \
		libdir=${D}/etc/lynx install || die

	dodoc CHANGES COPYHEADER COPYING INSTALLATION PROBLEMS README
	docinto docs
	dodoc docs/*
	docinto lynx_help
	dodoc lynx_help/*.txt
	dohtml -r lynx_help
	
	# small little manpage glitch
	rm ${D}/usr/share/man/lynx.1
	newman lynx.man lynx.1
}
