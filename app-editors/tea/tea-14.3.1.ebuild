# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-14.3.1.ebuild,v 1.1 2006/12/10 19:35:42 welp Exp $

inherit eutils

DESCRIPTION="Small GTK+ text editor"
HOMEPAGE="http://tea-editor.sourceforge.net"
SRC_URI="mirror://sourceforge/tea-editor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 gnome"

RDEPEND=">=x11-libs/gtk+-2.2
	>=app-text/aspell-0.50.5
	gnome? ( >=x11-libs/gtksourceview-1.6.1
		gnome-base/gnome-vfs )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
	$(use_enable ipv6 ) \
	$(use_enable !gnome legacy ) \
	|| die "Configure failed!"

	emake || die "Make failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "Make Install failed!"

	doicon ${FILESDIR}/tea.png
#	domenu ${FILESDIR}/tea.desktop
	make_desktop_entry tea Tea tea Office
}
