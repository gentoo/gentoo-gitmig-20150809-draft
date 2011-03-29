# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/conspire/conspire-0.20.ebuild,v 1.5 2011/03/29 12:49:20 angelos Exp $

EAPI=1
inherit eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A high quality IRC client which uses a multitude of interfaces"
HOMEPAGE="http://www.nenolod.net/conspire/"
SRC_URI="http://distfiles.atheme.org/${MY_P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~sparc x86"
IUSE="python gnutls ipv6 nls mmx socks5 dbus"
DEPEND="nls? ( dev-util/intltool )
	dev-util/pkgconfig"
RDEPEND=">=dev-libs/libmowgli-0.6.0
	>=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2.14:2
	x11-libs/libnotify
	x11-libs/libsexy
	dbus? ( >=dev-libs/dbus-glib-0.60 )
	python? ( >=dev-lang/python-2.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-de798c3d89ea.diff"
}

src_compile() {
	econf \
		$(use_enable socks5 socks) \
		$(use_enable ipv6) \
		$(use_enable gnutls) \
		$(use_enable python) \
		$(use_enable mmx) \
		$(use_enable nls) \
		$(use_enable dbus) \
		--enable-spell=libsexy \
		--enable-regex \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS TODO
}
