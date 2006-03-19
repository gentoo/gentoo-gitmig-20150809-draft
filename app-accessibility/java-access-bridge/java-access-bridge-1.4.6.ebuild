# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/java-access-bridge/java-access-bridge-1.4.6.ebuild,v 1.6 2006/03/19 11:13:58 corsair Exp $

inherit java-pkg gnome2

DESCRIPTION="Gnome Java Accessibility Bridge"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libbonobo-2
	>=gnome-extra/at-spi-1.3.9

	>=virtual/jre-1.4"

DEPEND=">=gnome-base/libbonobo-2
	>=gnome-extra/at-spi-1.3.9

	>=virtual/jdk-1.4
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"


pkg_setup() {
	G2CONF="--with-java-home=${JDK_HOME}"
}

src_install() {
	gnome2_src_install

	java-pkg_dojar ${D}/usr/share/jar/*.jar

	insinto /usr/share/${PN}
	doins ${D}/usr/share/jar/*.properties

	rm -rf ${D}/usr/share/jar
}

pkg_postinst() {
	einfo
	einfo "The Java Accessibility Bridge for GNOME has been installed."
	einfo
	einfo "To enable accessibility support with your java applications, you"
	einfo "have to enable CORBA traffic over IP. To do this, you may add the"
	einfo "following line to your /etc/orbitrc or ~/.orbitrc file:"
	einfo
	einfo "  ORBIIOPIPv4=1"
	einfo
}
