# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/tin/tin-1.7.7-r1.ebuild,v 1.1 2005/02/20 23:16:15 agriffis Exp $

inherit eutils

DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
HOMEPAGE="http://www.tin.org/"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v1.7/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~arm ~amd64 ~ia64 ~ppc-macos"
IUSE="crypt debug ipv6 ncurses nls X"

DEPEND="ncurses? ( sys-libs/ncurses )
	X? ( virtual/x11 )
	nls? ( sys-devel/gettext )
	crypt? ( app-crypt/gnupg )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/tin-1.7.7-mbox-mmdf.patch
}

src_compile() {
	local myconf=""
	[ -f ${ROOT}/etc/NNTP_INEWS_DOMAIN ] \
		&& myconf="${myconf} --with-domain-name=/etc/NNTP_INEWS_DOMAIN"

	econf \
		--verbose \
		--enable-nntp-only \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--enable-fascist-newsadmin \
		$(use_enable ncurses curses) \
		$(use_with ncurses) \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_with X x) \
		$(use_enable crypt pgp-gpg) \
		$(use_enable nls) \
		${myconf} || die "econf failed"
	emake build || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc doc/{CHANGES{,.old},CREDITS,TODO,WHATSNEW,*.sample,*.txt} || die "dodoc failed"
	insinto /etc/tin
	doins doc/tin.defaults || die "doins failed"
}
