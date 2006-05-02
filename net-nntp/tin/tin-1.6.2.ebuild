# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/tin/tin-1.6.2.ebuild,v 1.4 2006/05/02 23:38:59 weeve Exp $

inherit versionator

DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
HOMEPAGE="http://www.tin.org/"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ia64 ~ppc-macos sparc x86"
IUSE="ncurses ipv6"

DEPEND="ncurses? ( sys-libs/ncurses )"

src_compile() {
	local myconf=""
	[ -f /etc/NNTP_INEWS_DOMAIN ] \
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
		${myconf} || die "econf failed"
	emake build || die "emake failed"
}

src_install() {
	dobin src/tin || die "dobin failed"
	dosym tin /usr/bin/rtin || die "dosym failed"
	doman doc/tin.1 || die "doman failed"
	dodoc doc/* || die "dodoc failed"
	insinto /etc/tin
	doins doc/tin.defaults || die "doins failed"
}
