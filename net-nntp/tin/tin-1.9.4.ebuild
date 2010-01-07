# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/tin/tin-1.9.4.ebuild,v 1.2 2010/01/07 17:16:20 mr_bones_ Exp $

EAPI="2"

inherit versionator eutils

DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
HOMEPAGE="http://www.tin.org/"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~sparc ~x86"
IUSE="cancel-locks crypt debug evil forgery idn ipv6 nls unicode socks5 +etiquette"

DEPEND="sys-libs/ncurses
	dev-libs/libpcre
	dev-libs/uulib
	idn? ( net-dns/libidn )
	unicode? ( dev-libs/icu )
	nls? ( sys-devel/gettext )
	crypt? ( app-crypt/gnupg )
	socks5? ( net-proxy/dante )"

RDEPEND="${DEPEND}
	net-misc/urlview"

pkg_setup() {
	if use unicode && ! built_with_use sys-libs/ncurses unicode
	then
		die "For unicode support you need sys-libs/ncurses compiled with unicode support!"
	fi
}

src_configure() {

	if use evil
	then
		sed -i -e"s/# -DEVIL_INSIDE/-DEVIL_INSIDE/" src/Makefile.in
	fi

	if use forgery
	then
		sed -i -e"s/^CPPFLAGS.*/& -DFORGERY/" src/Makefile.in
	fi

	local screen="ncurses"
	use unicode && screen="ncursesw"

	if ! use etiquette; then
		myconf="${myconf} --disable-etiquette"
	fi

	if ! use evil && use cancel-locks; then
		die "USE=cancel-locks requires also USE=evil to generate MIDs and the Cancel-Lock:-Header."
	fi

	econf \
		--with-pcre=/usr \
		--enable-nntp-only \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--with-screen=${screen} \
		--with-nntp-default-server="${TIN_DEFAULT_SERVER:-${NNTPSERVER:-news.gmane.org}}" \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_enable crypt pgp-gpg) \
		$(use_enable nls) \
		$(use_enable cancel-locks) \
		$(use_with socks5) \
		${myconf} \
		|| die "econf failed"
}

src_install() {
	if has_version mail-client/mutt; then
		rm doc/mmdf.5 doc/mbox.5
	fi
	make DESTDIR="${D}" install || die "make install failed"

	dodoc doc/{CHANGES{,.old},CREDITS,TODO,WHATSNEW,*.sample,*.txt} || die "dodoc failed"
	insinto /etc/tin
	doins doc/tin.defaults || die "doins failed"
}
