# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/centericq/centericq-4.9.12-r1.ebuild,v 1.4 2004/07/15 16:28:18 tgall Exp $

inherit eutils

IUSE="bidi nls ssl"

DESCRIPTION="A ncurses ICQ/Yahoo!/AIM/IRC/MSN/Jabber Client"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"
HOMEPAGE="http://konst.org.ua/eng/software/centericq/info.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 sparc ~amd64 ~ppc hppa ~ppc64"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6g )
	bidi? ( dev-libs/fribidi )"

RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/centericq-4.9.12-gcc3.4.patch
}

src_compile() {
	# Options you can add to myopts
	# --disable-yahoo    Build without Yahoo!
	# --disable-aim      Build without AIM
	# --disable-irc      Build without IRC
	# --disable-msn      Build without MSN
	# --disable-jabber   Build without Jabber
	# --disable-rss      Build without RSS reader
	# --no-konst         Don't add contact list items
	# --disable-lj       Build without LiveJournal client"
	#                    supplied by author by default
	local myopts="--with-gnu-ld"

	use nls && myopts="${myopts} --enable-locales-fix" || myopts="${myopts} --disable-nls"

	use bidi && myopts="${myopts} --with-fribidi"

	use ssl && myopts="${myopts} --with-ssl"

	econf ${myopts} || die "Configure failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ README THANKS TODO
}
