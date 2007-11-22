# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/evolution-sharp/evolution-sharp-0.14.0.1.ebuild,v 1.1 2007/11/22 15:08:17 drac Exp $

inherit mono versionator eutils

DESCRIPTION="Mono bindings for Evolution"
HOMEPAGE="http://www.gnome.org/projects/beagle"
SRC_URI="mirror://gnome/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=gnome-extra/evolution-data-server-1.8.1-r1
	>=dev-lang/mono-1
	>=dev-dotnet/gtk-sharp-2.4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Use correct libdir in pkgconfig files
	sed -i -e 's:^libdir.*:libdir=@libdir@:' \
		-e 's:^prefix=:exec_prefix=:' \
		-e 's:prefix)/lib:libdir):' \
		"${S}"/*.pc.in || die "sed failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README
}
