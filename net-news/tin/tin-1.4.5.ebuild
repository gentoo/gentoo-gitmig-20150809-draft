# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/tin/tin-1.4.5.ebuild,v 1.9 2004/03/20 07:32:10 mr_bones_ Exp $

IUSE="ncurses"

S=${WORKDIR}/${P}
DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v1.4/${P}.tar.gz"
HOMEPAGE="http://www.tin.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="ncurses? ( sys-libs/ncurses )"

src_compile() {
	local myconf

	use ncurses && myconf="--enable-curses --with-ncurses"
	[ -f /etc/NNTP_INEWS_DOMAIN ] \
		&& myconf="${myconf} --with-domain-name=/etc/NNTP_INEWS_DOMAIN"

	./configure \
		--verbose \
		--enable-nntp-only \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--enable-fascist-newsadmin \
		${myconf} || die
	make build || die
}

src_install() {
	dobin src/tin
	ln -s tin ${D}/usr/bin/rtin
	doman doc/tin.1
	dodoc doc/*
	insinto /etc/tin
	doins doc/tin.defaults
}
