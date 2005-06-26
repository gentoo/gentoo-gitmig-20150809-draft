# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-gnome/xchat-gnome-0.4.ebuild,v 1.6 2005/06/26 16:39:25 chainsaw Exp $

inherit gnome2

DESCRIPTION="GNOME frontend for the popular X-Chat IRC client"
HOMEPAGE="http://xchat-gnome.navi.cx/"
SRC_URI="http://flapjack.navi.cx/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="perl tcltk python ssl mmx ipv6 nls"

RDEPEND=">=dev-libs/glib-2.0.3
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2
	ssl? ( >=dev-libs/openssl-0.9.6d )
	perl? ( >=dev-lang/perl-5.6.1 )
	python? ( dev-lang/python )
	tcltk? ( dev-lang/tcl )
	!net-irc/xchat"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	nls? ( sys-devel/gettext )"

src_compile() {
	# We disable gtkfe and textfe, if you want them please use net-irc/xchat instead!
	econf \
		--disable-textfe \
		--disable-gtkfe \
		--enable-gnomefe \
		$(use_enable ssl openssl) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcltk tcl) \
		$(use_enable mmx) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install"

	rm -f \
		"${D}"/usr/share/applications/xchat.desktop \
		"${D}"/usr/share/pixmaps/xchat.png

	# install plugin development header
	insinto /usr/include/xchat
	doins src/common/xchat-plugin.h || die "doins failed"

	dodoc src/fe-gnome/{BUGS,ChangeLog,TODO} || die "dodoc failed"
}

pkg_postinst() {
	gnome2_gconf_install
}
