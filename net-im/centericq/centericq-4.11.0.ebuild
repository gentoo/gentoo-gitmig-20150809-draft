# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/centericq/centericq-4.11.0.ebuild,v 1.3 2005/01/22 23:59:35 wschlich Exp $

inherit eutils

IUSE="bidi nls ssl icq jabber aim msn yahoo" # gg irc rss lj

DESCRIPTION="A ncurses ICQ/Yahoo!/AIM/IRC/MSN/Jabber/GaduGadu/RSS/LiveJournal Client"
SRC_URI="http://thekonst.net/download/${P}.tar.bz2"
HOMEPAGE="http://thekonst.net/en/centericq"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~amd64 ~ppc ~hppa ~ppc64"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	icq? ( !net-libs/libicq2000 )
	ssl? ( >=dev-libs/openssl-0.9.6g )
	msn? ( net-misc/curl )
	bidi? ( dev-libs/fribidi )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	local myopts="--with-gnu-ld --disable-konst"
	use nls && myopts="${myopts} --enable-locales-fix" || myopts="${myopts} --disable-nls"
	use bidi && myopts="${myopts} --with-fribidi"
	use ssl && myopts="${myopts} --with-ssl"

	use icq || myopts="${myopts} --disable-icq"
	use jabber || myopts="${myopts} --disable-jabber"
	use aim || myopts="${myopts} --disable-aim"
	use msn || myopts="${myopts} --disable-msn"
	use yahoo || myopts="${myopts} --disable-yahoo"
#	use gg || myopts="${myopts} --disable-gg"
#	use irc || myopts="${myopts} --disable-irc"
#	use rss || myopts="${myopts} --disable-rss"
#	use lj || myopts="${myopts} --disable-lj"

	econf ${myopts} || die "Configure failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ README THANKS TODO
}
