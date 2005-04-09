# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pavuk/pavuk-0.9.32.ebuild,v 1.3 2005/04/09 14:42:18 dsd Exp $

inherit eutils

DESCRIPTION="Web spider and website mirroring tool"
HOMEPAGE="http://www.pavuk.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="ssl X gnome mozilla socks5 nls"

DEPEND=">=sys-apps/sed-4
	sys-devel/gettext
	sys-libs/zlib
	ssl? ( dev-libs/openssl )
	X? ( virtual/x11 )
	gnome? ( gnome-base/gnome-libs )
	mozilla? ( www-client/mozilla )
	socks5? ( net-misc/tsocks )"

src_compile() {
	econf \
		--enable-threads \
		--with-regex=auto \
		--disable-gtk \
		$(use_with X x) \
		$(use_enable ssl) \
		$(use_enable gnome) \
		$(use_enable mozilla js) \
		$(use_enable socks5 socks) \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die
}

src_install() {
	# fix sandbox violation for gnome .desktop and icon, and gnome menu entry
	if use gnome
	then
		sed -i 's:GNOME_PREFIX = /usr:GNOME_PREFIX = ${D}usr:' Makefile
		sed -i 's:GNOME_PREFIX = /usr:GNOME_PREFIX = ${D}usr:' icons/Makefile
		sed -i 's:Type=Internet:Type=Application:' pavuk.desktop
	fi

	make install DESTDIR=${D}

	dodoc README CREDITS FAQ NEWS AUTHORS BUGS \
		TODO MAILINGLIST ChangeLog wget-pavuk.HOWTO jsbind.txt \
		pavuk_authinfo.sample  pavukrc.sample
}
