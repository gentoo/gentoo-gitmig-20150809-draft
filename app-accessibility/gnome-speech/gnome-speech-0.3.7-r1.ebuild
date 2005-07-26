# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.3.7-r1.ebuild,v 1.1 2005/07/26 00:15:00 leonardop Exp $

inherit java-pkg gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="freetts static"

RDEPEND="app-accessibility/festival
	>=gnome-base/libbonobo-1.97
	>=gnome-base/orbit-2.3.94
	freetts? (
		virtual/jre
		=app-accessibility/freetts-1.2*
		app-accessibility/java-access-bridge )"

# festival is not required for compilation
DEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/orbit-2.3.94
	freetts? (
		virtual/jdk
		=app-accessibility/freetts-1.2*
		app-accessibility/java-access-bridge
		dev-java/java-config )
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e 's/@GNOME_SPEECH_INSTALLED_CLASSPATH@/$(java-config -p gnome-speech-1,java-access-bridge)/' \
	-i drivers/freetts/freetts-synthesis-driver.in || die
}

src_compile() {
	G2CONF="${G2CONF} $(use_enable static)"

	if use freetts; then
		local JABDIR="${ROOT}/usr/share/java-access-bridge/lib/"
		G2CONF="${G2CONF} --with-java-home=${JAVA_HOME} \
				--with-jab-dir=${JABDIR} --with-freetts-dir=${ROOT}/usr/share/freetts/lib"

		sed -i \
			-e 's:\(GNOME_SPEECH_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
			-e 's:\(FREETTS_DRIVER_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
			${S}/configure
	else
		export JAVAC=no
	fi

	gnome2_src_compile
}

src_install() {
	gnome2_src_install

	if use freetts
	then
		java-pkg_dojar ${D}/usr/share/jar/*.jar
		rm -rf ${D}/usr/share/jar
	fi
}

pkg_postinst() {
	einfo
	einfo "Gnome Speech has been successfully installed. You may now use the"
	einfo "speech interface using app-accessibility/gnopernicus."
	einfo
}
