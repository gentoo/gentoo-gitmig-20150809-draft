# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.3.2-r1.ebuild,v 1.2 2004/03/24 14:06:42 gustavoz Exp $

inherit java-pkg gnome2

IUSE="java"

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"

KEYWORDS="~x86 ~hppa ~alpha ~ia64 ~sparc"
LICENSE="LGPL-2"


RDEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/ORBit2-2.3.94
	java? ( virtual/jdk
		app-accessibility/java-access-bridge )"
# Support for freetts still pending, since the tarball doesn't actually
# include the driver...
# See http://bugs.gnome.org/show_bug.cgi?id=137337
#	freetts? ( app-accessibility/freetts
#		!java? ( virtual/jdk
#			app-accessibility/java-access-bridge ) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	java? ( dev-java/java-config )"

DOCS="AUTHORS ChangeLog COPYING NEWS README"


if [ `use java` ]
then
	G2CONF="${G2CONF} --with-java-home=$(java-config --jdk-home)"
	G2CONF="${G2CONF} --with-jab-dir=${ROOT}/usr/share/java-access-bridge/lib"
else
	export JAVAC=no
fi


src_install() {
	gnome2_src_install

	if [ `use java` ]
	then
		java-pkg_dojar ${D}/usr/share/jar/*.jar
		rm -rf ${D}/usr/share/jar
	fi
}
