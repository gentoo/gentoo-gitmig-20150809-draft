# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libgconf-java/libgconf-java-2.8.3.1.ebuild,v 1.1 2005/03/12 19:25:34 luckyduck Exp $

#
# WARNING: Because java-gnome is a set of bindings to native GNOME libraries, 
# it has, like any GNOME project, a massive autoconf setup, and unlike many 
# other java libraries, it has its own [necessary] `make install` step.
# As a result, this ebuild is VERY sensitive to the internal layout of the
# upstream project. Because these issues are currently evolving upstream,
# simply version bumping this ebuild is not likely to work but FAILURES WILL
# BE VERY SUBTLE IF IT DOES NOT WORK.
# 

inherit eutils gnome.org

DESCRIPTION="Java bindings for GConf (allows GNOME/GTK applications writen in Java to store configuration information in gconf)"
HOMEPAGE="http://java-gnome.sourceforge.net/"
RDEPEND=">=gnome-base/gconf-2.8.0
	>=dev-java/libgtk-java-2.4.8.1
	>=virtual/jre-1.2"

#	It's not clear whether gnome is a gconf dependency or not.
#	>=dev-java/libgnome-java-2.8.2-r1

DEPEND="${RDEPEND}
	>=virtual/jdk-1.2
	app-arch/zip"

#
# Critical that this match gconf's apiversion
#
SLOT="2.8"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gcj"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libgconf-java-2.8.3.1_gentoo-PN-SLOT.patch
}

src_compile() {
	local conf

	use gcj	|| conf="${conf} --without-gcj-compile"

	cd ${S}

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
			${conf} || die "./configure failed"
	make || die
}

src_install() {
	# workaround Makefile bug not creating necessary parent directories
	mkdir -p ${D}/usr/lib
	mkdir -p ${D}/usr/share/java
	mkdir -p ${D}/usr/lib/pkgconfig
	mkdir -p ${D}/usr/share/doc/libgconf${SLOT}-java

	make prefix=${D}/usr install || die

	# actually, at time of writing, there were no DOCUMENTS, but leave it here...
	mv ${D}/usr/share/doc/libgconf${SLOT}-java ${D}/usr/share/doc/${PF}

	# the upstream install scatters things around a bit. The following cleans
	# that up to make it policy compliant.

	# I originally tried java-pkg_dojar here, but it has a few glitches 
	# like not copying symlinks as symlinks which makes a mess.

	dodir /usr/share/${PN}-${SLOT}/lib
	mv ${D}/usr/share/java/*.jar ${D}/usr/share/${PN}-${SLOT}/lib
	rm -rf ${D}/usr/share/java

	mkdir ${D}/usr/share/${PN}-${SLOT}/src
	cd ${S}/src/java
	zip -r ${D}/usr/share/${PN}-${SLOT}/src/libgconf-java-${PV}.src.zip *

	# again, with dojar misbehaving, better do to this manually for the 
	# time being. Yes, this is bad hard coding, but what in this ebuild isn't?

	echo "DESCRIPTION=${DESCRIPTION}" \
		>  ${D}/usr/share/${PN}-${SLOT}/package.env

	echo "CLASSPATH=/usr/share/${PN}-${SLOT}/lib/gconf${SLOT}.jar" \
		>> ${D}/usr/share/${PN}-${SLOT}/package.env
}
