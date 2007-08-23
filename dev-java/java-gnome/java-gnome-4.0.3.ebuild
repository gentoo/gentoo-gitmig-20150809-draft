# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-gnome/java-gnome-4.0.3.ebuild,v 1.2 2007/08/23 16:46:55 betelgeuse Exp $

JAVA_PKG_IUSE="doc examples source"

inherit eutils versionator java-pkg-2

DESCRIPTION="Java bindings for GTK and GNOME"
HOMEPAGE="http://java-gnome.sourceforge.net/"
SRC_URI="mirror://gnome/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2-with-linking-exception"
SLOT="4.0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.12.13
		>=x11-libs/gtk+-2.10.14
		>=gnome-base/libglade-2.6.1
		>=gnome-base/libgnome-2.18.0
		>=gnome-base/gnome-desktop-2.18.0
		>=virtual/jre-1.4"
DEPEND="${RDEPEND}
		dev-java/junit
		dev-lang/python
		>=virtual/jdk-1.4"

# Needs X11
RESTRICT="test"

src_compile() {
	epatch "${FILESDIR}/4.0.3-ccache-workaround.patch"

	./configure --prefix=/usr || die

	make || die "Compilation of java-gnome failed"

	if use doc; then
		make doc || die "Making documentation failed"
	fi
}

src_install(){
	java-pkg_doso tmp/*.so
	java-pkg_dojar tmp/*.jar

	dodoc AUTHORS HACKING NEWS README || die

	use doc && java-pkg_dojavadoc doc/api
	use examples && java-pkg_doexamples tests/prototype
	use source && java-pkg_dosrc src/bindings/org
}
