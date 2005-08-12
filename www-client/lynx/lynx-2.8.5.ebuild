# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/lynx/lynx-2.8.5.ebuild,v 1.4 2005/08/12 16:32:40 grobian Exp $

inherit eutils flag-o-matic

#MY_PV=${PV/.1d/rel.1}
DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="http://lynx.browser.org/"
SRC_URI="ftp://lynx.isc.org/${PN}2.8.5/${PN}${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
IUSE="ssl nls ipv6"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3
	nls? ( sys-devel/gettext )
	ssl? ( >=dev-libs/openssl-0.9.6 )"
PROVIDE="virtual/textbrowser"

S=${WORKDIR}/${PN}${PV//./-}

src_unpack() {
	unpack ${A}
	use userland_Darwin && epatch ${FILESDIR}/${P}-darwin.patch
}

src_compile() {
	local myconf
	use nls && myconf="${myconf} --enable-nls"
	use ssl && myconf="${myconf} --with-ssl=yes"
	use ipv6 && myconf="${myconf} --enable-ipv6"

	append-flags -DANSI_VARARGS

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
	dodoc CHANGES COPYHEADER INSTALLATION PROBLEMS README
	docinto docs
	dodoc docs/*
	docinto lynx_help
	dodoc lynx_help/*.txt
	dohtml -r lynx_help

	# small little manpage glitch
	rm ${D}/usr/share/man/lynx.1
	newman lynx.man lynx.1
}
