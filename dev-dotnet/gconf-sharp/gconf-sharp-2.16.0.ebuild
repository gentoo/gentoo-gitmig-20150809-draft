# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gconf-sharp/gconf-sharp-2.16.0.ebuild,v 1.8 2008/11/23 20:48:40 loki_val Exp $

GTK_SHARP_TARBALL_PREFIX="gnome-sharp"
GTK_SHARP_REQUIRED_VERSION="2.10"

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="${DEPEND}
		>=gnome-base/gconf-2.0
		|| ( >=dev-dotnet/gtk-sharp-2.12.6 =dev-dotnet/glade-sharp-2.10* )
		=dev-dotnet/gnome-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*"

GTK_SHARP_COMPONENT_BUILD="gnome"
GTK_SHARP_COMPONENT_BUILD_DEPS="art"
GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"

pkg_setup() {
	if has_version '>=dev-dotnet/gtk-sharp-2.12.6'
	then
		if ! built_with_use --missing false '>=dev-dotnet/gtk-sharp-2.12.6' 'glade'
		then
			die ">=dev-dotnet/gtk-sharp-2.12.6 must be built with useflag 'glade' enabled"
		fi
	fi
}

src_unpack() {
	gtk-sharp-component_src_unpack

	# Fix need as GConf.PropertyEditors references a locally built dll
	sed -i "s:${GTK_SHARP_LIB_DIR}/gconf-sharp.dll:../GConf/gconf-sharp.dll:" \
		${S}/gconf/GConf.PropertyEditors/Makefile.in
}
