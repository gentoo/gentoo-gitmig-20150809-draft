# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/lynx/lynx-2.8.5-r2.ebuild,v 1.1 2005/11/13 01:45:16 seemant Exp $

inherit eutils flag-o-matic

PATCHVER=0.1

MY_P=${P/-/}
DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="http://lynx.browser.org/"
SRC_URI="ftp://lynx.isc.org/${MY_P}/${MY_P}.tar.bz2
	http://dev.gentoo.org/~seemant/distfiles/${P}-gentoo-${PATCHVER}.tar.bz2
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
IUSE="ssl nls ipv6"

DEPEND="sys-libs/ncurses
	sys-libs/zlib
	nls? ( sys-devel/gettext )
	ssl? ( >=dev-libs/openssl-0.9.6 )"
PROVIDE="virtual/textbrowser"

S=${WORKDIR}/${PN}${PV//./-}
PATCHDIR=${WORKDIR}/gentoo/patches

src_unpack() {
	unpack ${A}; cd ${S}
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
	use userland_Darwin && epatch ${FILESDIR}/${P}-darwin.patch
}

src_compile() {
	local myconf
	use ssl && myconf="${myconf} --with-ssl=yes"

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
		$(use_enable nls) \
		$(use_enable ipv6) \
		${myconf} || die

	emake || die "compile problem"
}

src_install() {
	einstall libdir=${D}/etc/lynx || die

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
