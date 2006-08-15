# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/blam/blam-1.8.2-r1.ebuild,v 1.3 2006/08/15 10:35:48 dsd Exp $

inherit mono eutils autotools

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
	cd ${S}

	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib/blam:$(libdir)/blam:' \
			-e "s:@prefix@/lib:@prefix@/$(get_libdir):" \
			${S}/{,lib,libblam,src}/Makefile.{in,am} ${S}/blam.in || die
	fi

	# Fix for bug 94524, bad int definition
	epatch ${FILESDIR}/${P}-64-bit-int.diff

	# build against seamonkey
	epatch ${FILESDIR}/${P}-seamonkey.patch

	eautoconf
	eautoheader
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
