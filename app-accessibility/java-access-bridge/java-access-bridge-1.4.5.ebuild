# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/java-access-bridge/java-access-bridge-1.4.5.ebuild,v 1.5 2005/08/08 08:39:24 corsair Exp $

inherit java-pkg gnome2

DESCRIPTION="Gnome Java Accessibility Bridge"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libbonobo-2
	>=gnome-extra/at-spi-1.3.9
	>=virtual/jdk-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile() {
	if [ -z "${JDK_HOME}" ] || [ ! -d "${JDK_HOME}" ]
	then
		eerror "In order to compile java sources you have to set the"
		eerror "\$JDK_HOME environment properly."
		eerror ""
		eerror "You may do this using dev-java/java-config."
		die "Couldn't find a valid JDK home"
	fi

	G2CONF="${G2CONF} --with-java-home=${JDK_HOME}"
	gnome2_src_compile
}

src_install() {
	gnome2_src_install

	java-pkg_dojar ${D}/usr/share/jar/*.jar

	insinto /usr/share/${PN}
	doins ${D}/usr/share/jar/*.properties

	rm -rf ${D}/usr/share/jar

	einfo "Installing symbolic links into ${JDK_HOME}/jre/lib"

	dodir ${JDK_HOME}/jre/lib/ext
	dosym \
		${ROOT}/usr/share/${PN}/accessibility.properties \
		${JDK_HOME}/jre/lib/accessibility.properties

	local jarfile
	for jar in ${D}/usr/share/${PN}/lib/*.jar
	do
		jarfile=$(basename $jar)
		dosym \
			${ROOT}/usr/share/${PN}/lib/$jarfile \
			${JDK_HOME}/jre/lib/ext/$jarfile
	done
}

pkg_postinst() {
	einfo ""
	einfo "The Java Accessibility Bridge for GNOME has been installed."
	einfo ""
	einfo "To enable accessibility support with your java applications, you"
	einfo "have to enable CORBA traffic over IP. To do this, you may add the"
	einfo "following line to your /etc/orbitrc or ~/.orbitrc file:"
	einfo ""
	einfo "  ORBIIOPIPv4=1"
	einfo ""
}
