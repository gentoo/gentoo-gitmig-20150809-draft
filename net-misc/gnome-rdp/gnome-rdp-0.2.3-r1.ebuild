# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnome-rdp/gnome-rdp-0.2.3-r1.ebuild,v 1.1 2010/11/22 13:41:38 voyageur Exp $

EAPI=2

inherit eutils gnome2 mono

DESCRIPTION="Remote Desktop Client for the GNOME desktop"
HOMEPAGE="http://sourceforge.net/projects/gnome-rdp"
SRC_URI="mirror://sourceforge/gnome-rdp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+rdesktop +vnc"

RDEPEND=">=dev-db/sqlite-2.8
		>=dev-libs/glib-2.0
		>=dev-dotnet/glade-sharp-2.10
		>=dev-dotnet/gtk-sharp-2.0
		>=dev-dotnet/gnome-keyring-sharp-1.0.0
		>=dev-dotnet/gnome-sharp-2.16
		>=dev-dotnet/vte-sharp-2.16
		>=x11-libs/gtk+-2.4
		>=net-misc/openssh-3
		>=x11-terms/gnome-terminal-2
		rdesktop? ( >=net-misc/rdesktop-1.3 )
		vnc? ( >=net-misc/tightvnc-1.2 )"

DEPEND="${RDEPEND}
		dev-dotnet/nant
		>=dev-util/intltool-0.21"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	sed -i -e "s/gnome-keyring-sharp/gnome-keyring-sharp-1.0/" gnome-rdp.build || die "sed failed"
	epatch "${FILESDIR}"/${P}-mono-2.8.patch
}

src_configure() {
	default
}

src_compile() {
	nant -D:DESTDIR="${D}" || die
}

src_install() {
	nant -D:DESTDIR="${D}" install|| die
}
