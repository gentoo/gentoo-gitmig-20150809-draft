# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.3.9.ebuild,v 1.9 2006/03/19 11:14:46 corsair Exp $

inherit java-pkg gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="freetts"

RDEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/orbit-2.3.94
	>=dev-libs/glib-2
	freetts? (
		virtual/jre
		=app-accessibility/freetts-1.2*
		>=app-accessibility/java-access-bridge-1.4.6 )

	app-accessibility/festival"

DEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/orbit-2.3.94
	>=dev-libs/glib-2
	freetts? (
		virtual/jdk
		=app-accessibility/freetts-1.2*
		app-accessibility/java-access-bridge
		dev-java/java-config )

	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README"


pkg_setup() {
	if use freetts; then
		local JABDIR="${ROOT}/usr/share/java-access-bridge/lib/"

		G2CONF="--with-java-home=${JAVA_HOME} \
			--with-jab-dir=${JABDIR} \
			--with-freetts-dir=${ROOT}/usr/share/freetts/lib"
	else
		export JAVAC=no
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	if use freetts; then
		sed -i -e \
			's/@GNOME_SPEECH_INSTALLED_CLASSPATH@/$(java-config -p gnome-speech-1,java-access-bridge)/' \
			drivers/freetts/freetts-synthesis-driver.in || die "sed error"
	fi

	sed -i \
		-e 's:\(GNOME_SPEECH_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
		-e 's:\(FREETTS_DRIVER_JAR_DIR=\).*:\1"/usr/share/java-access-bridge/lib/":' \
		${S}/configure
}

src_install() {
	gnome2_src_install

	if use freetts; then
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
