# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/blam/blam-1.8.4.ebuild,v 1.5 2008/11/25 16:11:26 loki_val Exp $

inherit mono eutils autotools

DESCRIPTION="A RSS aggregator written in C#"
HOMEPAGE="http://www.cmartin.tk/blam.html"
SRC_URI="http://www.cmartin.tk/blam/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.17
		>=dev-dotnet/gtk-sharp-2.8.2
		|| ( >=dev-dotnet/gtk-sharp-2.12.6 >=dev-dotnet/glade-sharp-2.8.2 )
		>=dev-dotnet/gconf-sharp-2.8.2
		>=dev-dotnet/gecko-sharp-0.11-r1
		>=gnome-base/libgnomeui-2.2
		>=gnome-base/gconf-2.4"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		>=dev-util/intltool-0.25"

# Disable parallel builds
MAKEOPTS="$MAKEOPTS -j1"

pkg_setup() {
	if has_version '>=dev-dotnet/gtk-sharp-2.12.6'
	then
		if ! built_with_use --missing false 'dev-dotnet/gtk-sharp' 'glade'
		then
			eerror "Please rebuild >=dev-dotnet/gtk-sharp-2.12.6 with USE='glade'"
			die "Please rebuild >=dev-dotnet/gtk-sharp-2.12.6 with USE='glade'"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if [[ "$(get_libdir)" != "lib" ]] ; then
		sed -i -e 's:$(prefix)/lib/blam:$(libdir)/blam:' \
			-e "s:@prefix@/lib:@prefix@/$(get_libdir):" \
			"${S}"/{,lib,libblam,src}/Makefile.{in,am} "${S}"/blam.in || die
	fi

	eautomake
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
