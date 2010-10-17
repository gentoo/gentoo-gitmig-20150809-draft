# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/lynx/lynx-2.8.6-r2.ebuild,v 1.18 2010/10/17 04:41:00 leio Exp $

inherit eutils

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P//./-}

DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="http://lynx.isc.org/"
SRC_URI="ftp://lynx.isc.org/${MY_P}/${MY_P}rel.4.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="bzip2 cjk ipv6 nls ssl unicode"

RDEPEND="sys-libs/ncurses
	sys-libs/zlib
	nls? ( virtual/libintl )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	bzip2? ( app-arch/bzip2 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

LANGS="ca cs da de et fr hu it ja nl pt_BR ru rw sl sv tr uk vi zh_CN zh_TW"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup() {
	if use unicode && ! built_with_use sys-libs/ncurses unicode; then
		eerror "Installing lynx with the unicode flag requires ncurses be"
		eerror "built with it as well. Please make sure your /etc/make.conf"
		eerror "or /etc/portage/package.use enables it, and re-install"
		eerror "ncurses with \`emerge --oneshot sys-libs/ncurses\`."
		die "Re-emerge ncurses with the unicode flag"
	fi
}

src_compile() {
	local myconf
	use unicode && myconf="--with-screen=ncursesw"

	econf \
		--enable-cgi-links \
		--enable-persistent-cookies \
		--enable-prettysrc \
		--enable-nsl-fork \
		--enable-file-upload \
		--enable-read-eta \
		--enable-color-style \
		--enable-scrollbar \
		--enable-included-msgs \
		--with-zlib \
		$(use_enable nls) \
		$(use_enable ipv6) \
		$(use_enable cjk) \
		$(use_enable linguas_ja japanese-utf8) \
		$(use_with ssl) \
		$(use_with bzip2 bzlib) \
		${myconf} || die

	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die

	dosed "s|^HELPFILE.*$|HELPFILE:file://localhost/usr/share/doc/${PF}/lynx_help/lynx_help_main.html|" \
			/etc/lynx.cfg
	dodoc CHANGES COPYHEADER PROBLEMS README
	docinto docs
	dodoc docs/*
	docinto lynx_help
	dodoc lynx_help/*.txt
	dohtml -r lynx_help/*
}
