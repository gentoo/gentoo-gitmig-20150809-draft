# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/centericq/centericq-4.9.9.ebuild,v 1.3 2004/02/17 13:26:53 dholm Exp $

inherit eutils

IUSE="nls ssl"

S=${WORKDIR}/${P}
DESCRIPTION="A ncurses ICQ/Yahoo!/AIM/IRC/Jabber Client"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"
HOMEPAGE="http://konst.org.ua/eng/software/centericq/info.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	=dev-libs/libsigc++-1.0*
	=dev-libs/glib-1.2*
	ssl? ( >=dev-libs/openssl-0.9.6g )
	bidi? ( dev-libs/fribidi )"

RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/missing_namespace.patch
	epatch ${FILESDIR}/nls.patch
}

src_compile() {
	# Options you can add to myopts
	# --disable-yahoo    Build without Yahoo!
	# --disable-aim      Build without AIM
	# --disable-irc      Build without IRC
	# --disable-jabber   Build without Jabber
	# --disable-rss      Build without RSS reader
	# --no-konst         Don't add contact list items
	# --disable-lj       Build without LiveJournal client"
	#                    supplied by author by default
	local myopts="--with-gnu-ld"

	use nls || myopts="${myopts} --disable-nls"

	use bidi && myopts="${myopts} --with-fribidi"

	use ssl && myopts="${myopts} --with-ssl"

	econf ${myopts} || die "Configure failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ README THANKS TODO
}
