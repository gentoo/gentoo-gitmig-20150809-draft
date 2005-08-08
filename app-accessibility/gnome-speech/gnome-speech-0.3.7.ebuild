# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.3.7.ebuild,v 1.7 2005/08/08 08:37:06 corsair Exp $

inherit java-pkg gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha ~amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE="freetts static"

RDEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/orbit-2.3.94
	freetts? (
		=app-accessibility/freetts-1.2*
		virtual/jdk
		app-accessibility/java-access-bridge
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile() {
	G2CONF="${G2CONF} $(use_enable static)"

	if use freetts
	then
		if [ -z "${JDK_HOME}" ] || [ ! -d "${JDK_HOME}" ]
		then
			eerror "The FreeTTS driver includes java components. In order to"
			eerror "compile java sources you have to set the\$JDK_HOME"
			eerror "environment properly."
			eerror ""
			eerror "You may do this using dev-java/java-config."
			die "Couldn't find a valid JDK home"
		fi

		local JABDIR="${ROOT}/usr/share/java-access-bridge/lib"
		G2CONF="${G2CONF} --with-java-home=${JDK_HOME} \
--with-jab-dir=${JABDIR} --with-freetts-dir=${ROOT}/usr/share/freetts/lib"

		sed -i \
	-e 's:\(GNOME_SPEECH_JAR_DIR=\).*:\1"/usr/share/gnome-speech-1/lib":' \
	-e 's:\(FREETTS_DRIVER_JAR_DIR=\).*:\1"/usr/share/gnome-speech-1/lib":' \
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
	einfo ""
	einfo "Gnome Speech has been successfully installed. You may now use the"
	einfo "speech interface using app-accessibility/gnopernicus."
	einfo ""
	einfo "Please note that gnome-speech relies on external programs that"
	einfo "implement the actual text-to-speech funcionality. Supported"
	einfo "implementations include festival and freetts."
	einfo ""
	einfo "The festival driver is always installed with gnome-speech and"
	einfo "should work as-is if you install app-accessibility/festival."
	einfo "The freetts driver is installed if you enable the 'freetts' USE"
	einfo "flag when installing gnome-speech."
	einfo ""
}
