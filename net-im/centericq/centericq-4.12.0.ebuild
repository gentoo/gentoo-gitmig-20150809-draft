# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/centericq/centericq-4.12.0.ebuild,v 1.1 2004/10/17 22:25:31 wschlich Exp $

inherit eutils

IUSE="bidi nls ssl icq jabber aim msn yahoo" # gg irc rss lj

DESCRIPTION="A ncurses ICQ/Yahoo!/AIM/IRC/MSN/Jabber/GaduGadu/RSS/LiveJournal Client"
SRC_URI="http://thekonst.net/download/${P}.tar.bz2"
HOMEPAGE="http://thekonst.net/en/centericq"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~hppa ~ppc64"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6g )
	msn? ( net-misc/curl )
	bidi? ( dev-libs/fribidi )"

RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	local myopts="--with-gnu-ld --disable-konst"
	use nls >&/dev/null && myopts="${myopts} --enable-locales-fix" || myopts="${myopts} --disable-nls"
	use bidi >&/dev/null && myopts="${myopts} --with-fribidi"
	use ssl >&/dev/null && myopts="${myopts} --with-ssl"

	use icq >&/dev/null || myopts="${myopts} --disable-icq"
	use jabber >&/dev/null || myopts="${myopts} --disable-jabber"
	use aim >&/dev/null || myopts="${myopts} --disable-aim"
	use msn >&/dev/null || myopts="${myopts} --disable-msn"
	if use msn >&/dev/null && ! use ssl >&/dev/null; then
		eerror ""
		eerror "USE flag problem"
		eerror "================"
		eerror "'msn' USE flag detected, but 'ssl' USE flag missing:"
		eerror "MSN support needs libcurl with SSL support."
		eerror ""
		die "Please either activate the 'ssl' USE flag or deactivate the 'msn' USE flag for net-im/centericq"
	fi
	use yahoo >&/dev/null || myopts="${myopts} --disable-yahoo"
#	use gg >&/dev/null || myopts="${myopts} --disable-gg"
#	use irc >&/dev/null || myopts="${myopts} --disable-irc"
#	use rss >&/dev/null || myopts="${myopts} --disable-rss"
#	use lj >&/dev/null || myopts="${myopts} --disable-lj"

	econf ${myopts} || die "Configure failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ README THANKS TODO
}
