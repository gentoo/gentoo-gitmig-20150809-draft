# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtjava/qtjava-3.5.9.ebuild,v 1.6 2009/02/03 04:19:37 jmbsvicetto Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
EAPI="1"
inherit java-pkg-2 kde-meta

DESCRIPTION="Java bindings for QT"
HOMEPAGE="http://developer.kde.org/language-bindings/java/qtjava.html"

KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"
# libhpi for bug #208631
PATCHES=( "${FILESDIR}/no-gtk-glib-check.diff"
		"${FILESDIR}/${PN}-${SLOT}-javacflags.patch"
		"${FILESDIR}/no-libhpi.so-check.patch" )

pkg_setup() {
	if ! built_with_use x11-libs/qt:3 opengl ; then
		eerror "${CATEGORY}/${PN} needs Qt 3 built with OpenGL support."
		die "Please reemerge x11-libs/qt:3 with USE=\"opengl\"."
	fi

	kde_pkg_setup
	java-pkg-2_pkg_setup
}

src_unpack() {
	kde-meta_src_unpack

	sed -i -e "s#_JAVACFLAGS_#${JAVACFLAGS}#" \
		"${S}/qtjava/javalib/org/kde/qt/Makefile.am" || die "sed failed"
}

src_compile() {
	myconf="${myconf} --with-java=${JDK_HOME}"
	kde-meta_src_compile
}

# Doesn't really need kde, only qt? But then, it installs by default into $KDEDIR/...
src_install() {
	kde-meta_src_install

	local libdir="${D}/usr/kde/${SLOT}/$(get_libdir)"
	# Is there a cleaner way?
	rm -rf "${libdir}/java" || die "rm failed"

	java-pkg_dojar "${S}/${PN}/javalib/${PN}.jar"
	java-pkg_regso "${libdir}"/*.so
}
