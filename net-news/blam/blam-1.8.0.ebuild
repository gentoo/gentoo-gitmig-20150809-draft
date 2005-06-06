# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/blam/blam-1.8.0.ebuild,v 1.6 2005/06/06 08:22:48 dholm Exp $

inherit mono eutils

DESCRIPTION="A RSS aggregator written in C#"
HOMEPAGE="http://www.imendio.com/projects/blam/"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND=">=dev-lang/mono-1.1.4
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		=dev-dotnet/gtk-sharp-1.0*
		=dev-dotnet/gconf-sharp-1.0*
		=dev-dotnet/glade-sharp-1.0*
		=dev-dotnet/gecko-sharp-0.6*
		>=gnome-base/gconf-2.4"

src_unpack() {
	unpack ${A}
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib/blam:$(libdir)/blam:' \
			-e "s:@prefix@/lib:@prefix@/$(get_libdir):" \
			${S}/src/{,atom,rss}/Makefile.{in,am} \
			${S}/libblam/Makefile.{in,am} ${S}/blam.in || die
	fi
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
