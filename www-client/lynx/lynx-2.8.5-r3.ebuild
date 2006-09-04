# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/lynx/lynx-2.8.5-r3.ebuild,v 1.16 2006/09/04 08:47:33 vapier Exp $

inherit eutils flag-o-matic

MY_P="${P/-/}"
DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="http://lynx.browser.org/"
SRC_URI="ftp://lynx.isc.org/${MY_P}/${MY_P}.tar.bz2
	mirror://gentoo/${P}-rel5.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="bzip2 cjk ipv6 nls ssl"

DEPEND="sys-libs/ncurses
	sys-libs/zlib
	nls? ( sys-devel/gettext )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	bzip2? ( app-arch/bzip2 )"

S="${WORKDIR}/${PN}${PV//./-}"

src_unpack() {
	unpack ${A}; cd "${S}"
	epatch "${DISTDIR}/${P}"-rel5.patch.bz2
	epatch "${FILESDIR}/${P}"-darwin.patch
	epatch "${FILESDIR}/${P}"-tab_to.patch
}

src_compile() {
	local myconf
	use ssl && myconf="${myconf} --with-ssl=yes"
	use bzip2 && myconf="${myconf} --with-bzlib"

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
		$(use_enable cjk) \
		${myconf} || die

	emake -j1 || die "compile problem"
}

src_install() {
	einstall libdir="${D}"/etc/lynx || die

	dosed "s|^HELPFILE.*$|HELPFILE:file://localhost/usr/share/doc/${PF}/lynx_help/lynx_help/lynx_help_main.html|" \
			/etc/lynx/lynx.cfg
	dodoc CHANGES COPYHEADER INSTALLATION PROBLEMS README
	docinto docs
	dodoc docs/*
	docinto lynx_help
	dodoc lynx_help/*.txt
	dohtml -r lynx_help

	# small little manpage glitch
	rm "${D}"/usr/share/man/lynx.1
	newman lynx.man lynx.1
}
