# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/zeitgeist-sharp/zeitgeist-sharp-0.8.0.0.ebuild,v 1.1 2012/02/01 10:39:27 jlec Exp $

EAPI=4

inherit autotools-utils mono versionator

DIR_PV=$(get_version_component_range 1-2)
DIR_PV2=$(get_version_component_range 1-3)

DESCRIPTION="Mono DBus API wrapper for Zeitgeist"
HOMEPAGE="https://launchpad.net/zeitgeist-sharp/"
SRC_URI="
	http://launchpad.net/zeitgeist-sharp/${DIR_PV}/${DIR_PV2}/+download/${P}.tar.gz
	doc? ( http://launchpad.net/zeitgeist-sharp/${DIR_PV}/${DIR_PV2}/+download/${PN}-docs-${DIR_PV2}.tar.gz )"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"
IUSE="doc"

RDEPEND="
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-sharp-glib
	dev-dotnet/glib-sharp
	dev-lang/mono
	gnome-extra/zeitgeist"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_install() {
	autotools-utils_src_install
	use doc && dohtml -r "${WORKDIR}"/${PN}-docs/*
}
