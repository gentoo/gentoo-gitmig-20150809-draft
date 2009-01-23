# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/evolution-sharp/evolution-sharp-0.17.4.ebuild,v 1.5 2009/01/23 15:40:04 loki_val Exp $

inherit mono gnome.org

DESCRIPTION="Mono bindings for Evolution"
HOMEPAGE="http://www.gnome.org/projects/beagle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=gnome-extra/evolution-data-server-1.8.1-r1
	!>=gnome-extra/evolution-data-server-2.24
	>=dev-dotnet/gtk-sharp-2.4
	dev-lang/mono"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
