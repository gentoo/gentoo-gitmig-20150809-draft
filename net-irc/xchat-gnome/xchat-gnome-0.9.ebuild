# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-gnome/xchat-gnome-0.9.ebuild,v 1.1 2006/02/19 16:38:38 swegener Exp $

inherit gnome2 eutils

DESCRIPTION="GNOME frontend for the popular X-Chat IRC client"
HOMEPAGE="http://xchat-gnome.navi.cx/"
SRC_URI="http://releases.navi.cx/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="perl tcltk python ssl mmx ipv6 nls dbus"

RDEPEND=">=dev-libs/glib-2.0.3
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2
	>=x11-libs/gtk+-2.8
	>=x11-libs/libsexy-0.1.4
	ssl? ( >=dev-libs/openssl-0.9.6d )
	perl? ( >=dev-lang/perl-5.6.1 )
	python? ( dev-lang/python )
	tcltk? ( dev-lang/tcl )
	dbus? ( >=sys-apps/dbus-0.35 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/xchat-gnome-0.7-scrollkeeper.patch
}

src_compile() {
	econf \
		--enable-gnomefe \
		--enable-shm \
		$(use_enable ssl openssl) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcltk tcl) \
		$(use_enable mmx) \
		$(use_enable ipv6) \
		$(use_enable dbus) \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install"

	# install plugin development header
	insinto /usr/include/xchat-gnome
	doins src/common/xchat-plugin.h || die "doins failed"

	dodoc AUTHORS ChangeLog NEWS || die "dodoc failed"
}

pkg_postinst() {
	gnome2_gconf_install
}
