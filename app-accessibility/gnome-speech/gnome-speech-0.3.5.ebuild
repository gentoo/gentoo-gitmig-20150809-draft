# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.3.5.ebuild,v 1.1 2004/09/18 17:58:43 leonardop Exp $

inherit java-pkg gnome2

# Local USE flags: freetts
IUSE="java freetts"

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"

KEYWORDS="~x86 ~ppc ~hppa ~alpha ~ia64 ~sparc ~amd64"
LICENSE="LGPL-2"

RDEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/orbit-2.3.94
	java? ( virtual/jdk
		app-accessibility/java-access-bridge )
	freetts? ( =app-accessibility/freetts-1.2*
		!java? ( virtual/jdk
			app-accessibility/java-access-bridge ) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile() {
	if use java || use freetts
	then
		if [ -z "${JDK_HOME}" ] || [ ! -d "${JDK_HOME}" ]
		then
			eerror "In order to compile java sources you have to set the"
			eerror "\$JDK_HOME environment properly."
			eerror ""
			eerror "You can achieve this by using the java-config tool:"
			eerror "  emerge java-config"
			die "Couldn't find a valid JDK home"
		fi

		local JABDIR="${ROOT}/usr/share/java-access-bridge/lib"
		G2CONF="${G2CONF} --with-java-home=${JDK_HOME}"
		G2CONF="${G2CONF} --with-jab-dir=${JABDIR}"
	else
		export JAVAC=no
	fi

	if use freetts
	then
		G2CONF="${G2CONF} --with-freetts-dir=${ROOT}/usr/share/freetts/lib"
	fi

	gnome2_src_compile
}

src_install() {
	gnome2_src_install

	if use java
	then
		java-pkg_dojar ${D}/usr/share/jar/*.jar
		rm -rf ${D}/usr/share/jar
	fi
}
