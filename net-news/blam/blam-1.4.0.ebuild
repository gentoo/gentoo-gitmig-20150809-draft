# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/blam/blam-1.4.0.ebuild,v 1.4 2004/10/26 21:54:42 latexer Exp $

inherit mono gnome2

DESCRIPTION="A RSS aggregator written in C#"
HOMEPAGE="http://www.imendio.com/projects/blam/"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND=">=dev-dotnet/mono-1.0
		>=dev-dotnet/gtk-sharp-1.0
		>=gnome-base/gconf-2.4"

src_unpack() {
	if [ ! -f ${ROOT}/usr/share/gapi/gtkhtml-api.xml ]
	then
		echo
		eerror "No gtkhtml-sharp support found. Please re-emerge"
		eerror "gtk-sharp with 'gtkhtml' in your USE flags, and then"
		eerror "emerge blam."
		die "gtkhtml-sharp support missing."
	fi

	unpack ${A}
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
