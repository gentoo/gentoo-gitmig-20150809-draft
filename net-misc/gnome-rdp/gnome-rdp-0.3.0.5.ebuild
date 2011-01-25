# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-rdp/gnome-rdp-0.3.0.5.ebuild,v 1.1 2011/01/25 20:39:34 voyageur Exp $

EAPI=3

inherit eutils mono

DESCRIPTION="Remote Desktop Client for the GNOME desktop"
HOMEPAGE="http://sourceforge.net/projects/gnome-rdp"
SRC_URI="mirror://sourceforge/gnome-rdp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+rdesktop +vnc"

RDEPEND="dev-db/sqlite:3
		dev-dotnet/dbus-glib-sharp
		dev-dotnet/gconf-sharp:2
		dev-dotnet/glade-sharp:2
		dev-dotnet/glib-sharp:2
		dev-dotnet/gtk-sharp:2
		>=dev-dotnet/gnome-keyring-sharp-1.0
		>=net-misc/openssh-3
		>=x11-terms/gnome-terminal-2
		rdesktop? ( >=net-misc/rdesktop-1.3 )
		vnc? ( >=net-misc/tightvnc-1.2 )"
DEPEND="${RDEPEND}"

src_compile() {
	emake -C gnome-rdp-dockyplugin || die "dockyplugin compilation failed"
	emake || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install|| die "install failed"
	dodoc ChangeLog
	doicon Menu/${PN}.png
	domenu Menu/${PN}.desktop
}
