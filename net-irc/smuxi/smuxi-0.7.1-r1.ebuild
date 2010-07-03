# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/smuxi/smuxi-0.7.1-r1.ebuild,v 1.1 2010/07/03 18:52:38 pacho Exp $

EAPI=2

inherit base mono eutils autotools

DESCRIPTION="A flexible, irssi-like and user-friendly IRC client for the Gnome Desktop."
HOMEPAGE="http://www.smuxi.org/page/Download"
SRC_URI="http://smuxi.meebey.net/jaws/data/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"
LICENSE="|| ( GPL-2 GPL-3 )"

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/smartirc4net-0.4.5.1
	>=dev-dotnet/nini-1.1.0-r2
	>=dev-dotnet/log4net-1.2.10-r2
	gnome? ( >=dev-dotnet/gtk-sharp-2.12
		 >=dev-dotnet/gconf-sharp-2.12
		 >=dev-dotnet/glade-sharp-2.12
		 >=dev-dotnet/glib-sharp-2.12 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25
	>=sys-devel/gettext-0.17
	>=dev-util/pkgconfig-0.23"

src_prepare() {
	epatch "${FILESDIR}/${P}-mono26.patch"
	eautoreconf
}

src_configure() {
	econf	--disable-dependency-tracking	\
		--enable-engine-irc		\
		$(use_enable gnome frontend-gnome)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc FEATURES TODO README || die "dodoc failed"
}
