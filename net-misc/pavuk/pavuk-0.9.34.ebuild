# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pavuk/pavuk-0.9.34.ebuild,v 1.3 2006/02/25 20:27:37 vanquirius Exp $

inherit eutils

DESCRIPTION="Web spider and website mirroring tool"
HOMEPAGE="http://www.pavuk.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gnome gtk mozilla nls ssl"

DEPEND=">=sys-apps/sed-4
	sys-devel/gettext
	ssl? ( dev-libs/openssl )
	gnome? ( gnome-base/gnome-libs )
	mozilla? ( www-client/mozilla )
	=dev-libs/glib-1.2*
	gtk? (	>=x11-libs/gtk+-2.8.8
		( || (	x11-proto/xproto
			virtual/x11 )
		) )"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.8.8
	|| ( (	x11-libs/libXt
		x11-libs/libXmu
		x11-libs/libX11 )
		virtual/x11 )
	)
	virtual/libintl
	ssl? ( dev-libs/openssl )
	gnome? ( gnome-base/gnome-libs )
	mozilla? ( www-client/mozilla )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-0.9.34-nls.patch
}


src_compile() {
	econf \
		--enable-threads \
		--with-regex=auto \
		--disable-socks \
		$(use_enable gtk) \
		$(use_enable ssl) \
		$(use_enable gnome) \
		$(use_enable mozilla js) \
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

	make DESTDIR="${D}" install || die

	dodoc README CREDITS FAQ NEWS AUTHORS BUGS \
		TODO MAILINGLIST ChangeLog wget-pavuk.HOWTO jsbind.txt \
		pavuk_authinfo.sample  pavukrc.sample
}
