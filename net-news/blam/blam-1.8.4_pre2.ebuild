# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/blam/blam-1.8.4_pre2.ebuild,v 1.2 2006/12/19 02:44:36 compnerd Exp $

inherit mono eutils autotools

MY_P=${P/_/}

DESCRIPTION="A RSS aggregator written in C#"
HOMEPAGE="http://www.cmartin.tk/blam.html"
SRC_URI="http://www.cmartin.tk/blam/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.17
		>=dev-dotnet/gtk-sharp-2.8.2
		>=dev-dotnet/gconf-sharp-2.4
		>=dev-dotnet/glade-sharp-2.8.2
		>=dev-dotnet/gecko-sharp-0.11-r1
		>=gnome-base/libgnomeui-2.2
		>=gnome-base/gconf-2.4"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		>=dev-util/intltool-0.25"

# Disable parallel builds
MAKEOPTS="$MAKEOPTS -j1"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	if [[ "$(get_libdir)" != "lib" ]] ; then
		sed -i -e 's:$(prefix)/lib/blam:$(libdir)/blam:' \
			-e "s:@prefix@/lib:@prefix@/$(get_libdir):" \
			${S}/{,lib,libblam,src}/Makefile.{in,am} ${S}/blam.in || die
	fi

	# Fix for working with new mono versions
	epatch ${FILESDIR}/${P}-remove-funky-non-printable.diff

	# Fix to disambiguate some print stuff found in both
	# gtk-sharp and gnome-sharp in 2.10/2.16
	epatch ${FILESDIR}/${P}-gtk-sharp-2.10-compat.diff

	eautomake
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
