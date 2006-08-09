# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/tin/tin-1.8.2.ebuild,v 1.2 2006/08/09 20:30:13 grobian Exp $

inherit versionator eutils

DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
HOMEPAGE="http://www.tin.org/"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc-macos ~sparc ~x86"
IUSE="crypt debug ipv6 ncurses nls"

DEPEND="ncurses? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	crypt? ( app-crypt/gnupg )"
RDEPEND="${DEPEND}
	net-misc/urlview"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-various.patch
}

src_compile() {
	econf \
		--enable-nntp-only \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--enable-fascist-newsadmin \
		--with-nntp-default-server="${TIN_DEFAULT_SERVER:-${NNTPSERVER:-news.gmane.org}}" \
		$(use_enable ncurses curses) \
		$(use_with ncurses) \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_enable crypt pgp-gpg) \
		$(use_enable nls) \
		|| die "econf failed"
	emake build || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc doc/{CHANGES{,.old},CREDITS,TODO,WHATSNEW,*.sample,*.txt} || die "dodoc failed"
	insinto /etc/tin
	doins doc/tin.defaults || die "doins failed"
}
