# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/tin/tin-1.4.5.ebuild,v 1.1 2001/08/16 03:27:24 tadpol Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v1.4/${A}"
HOMEPAGE="http://www.tin.org/"
DEPEND="virtual/glibc
	ncurses? ( ~sys-libs/ncurses )"

src_compile() {
   local myopts

   [ "`use ncurses`" ] && myopts="--enable-curses --with-ncurses"
   [ -f /etc/NNTP_INEWS_DOMAIN ] && myopts="$myopts --with-domain-name=/etc/NNTP_INEWS_DOMAIN"

   ./configure --verbose --enable-nntp-only --enable-prototypes --disable-echo \
               --disable-mime-strict-charset --with-coffee  \
               --enable-fascist-newsadmin $myopts || die
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

