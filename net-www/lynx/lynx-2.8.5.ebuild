# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/lynx/lynx-2.8.5.ebuild,v 1.3 2004/04/08 17:39:44 dmwaters Exp $

IUSE="ssl nls ipv6"

#MY_PV=${PV/.1d/rel.1}
S=${WORKDIR}/${PN}${PV//./-}
DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="http://lynx.browser.org/"
SRC_URI="ftp://lynx.isc.org/lynx/${PN}2.8.5/${PN}${PV}.tar.bz2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ~amd64 ppc64"
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

	# GCC3.1 support -- check if it's really needed in
	# future. Some users report complete success with -r3 --
	# credit to lostlogix and carpaski. Resolves #3172
#	epatch ${FILESDIR}/${P}-gentoo.patch
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
		--enable-EXP_PERSISTENT_COOKIES \
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

	dosed "s|^HELPFILE.*$|HELPFILE:file://localhost/usr/share/doc/${PF}/lynx_help/lynx_help/lynx_help_main.html|" \
			/etc/lynx/lynx.cfg
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
