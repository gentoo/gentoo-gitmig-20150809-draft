# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/evolution-sharp/evolution-sharp-0.20.0.ebuild,v 1.1 2009/03/25 01:49:19 loki_val Exp $

EAPI=2

inherit mono gnome.org eutils

DESCRIPTION="Mono bindings for Evolution"
HOMEPAGE="http://www.gnome.org/projects/beagle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

#Does not build with <eds-2.24.0 - http://bugzilla.gnome.org/show_bug.cgi?id=563301

RDEPEND="
	|| (
		=gnome-extra/evolution-data-server-2.26*
		=gnome-extra/evolution-data-server-2.25*
		=gnome-extra/evolution-data-server-2.24*
	)
	>=dev-dotnet/glib-sharp-2.12
	>=dev-lang/mono-2"
DEPEND="${RDEPEND}
	userland_GNU? ( >=sys-apps/findutils-4.4.0 )
	>=dev-dotnet/gtk-sharp-gapi-2.12
	dev-util/pkgconfig"

src_configure() {
	econf --disable-static
}

src_compile() {
	emake CSC=gmcs || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README
	mono_multilib_comply
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
