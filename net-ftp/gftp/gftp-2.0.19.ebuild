# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-2.0.19.ebuild,v 1.3 2009/01/24 00:01:09 ken69267 Exp $

inherit eutils

DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="gtk ssl"

RDEPEND=">=dev-libs/glib-2
		 sys-devel/gettext
		 sys-libs/ncurses
		 sys-libs/readline
		 gtk? ( >=x11-libs/gtk+-2 )
		 ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

src_compile() {
	econf $(use_enable gtk gtkport) $(use_enable ssl) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog* README* THANKS TODO docs/USERS-GUIDE
}
