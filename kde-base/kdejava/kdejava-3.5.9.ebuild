# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdejava/kdejava-3.5.9.ebuild,v 1.4 2008/05/15 15:29:20 corsair Exp $

KMNAME=kdebindings
KMEXTRACTONLY=qtjava
KMCOPYLIB="libqtjavasupport qtjava/javalib/qtjava"
KM_MAKEFILESREV=1
EAPI="1"
inherit java-pkg-2 kde-meta

DESCRIPTION="KDE java bindings"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
IUSE=""
COMMONDEPEND="|| ( ( >=kde-base/kwin-${PV}:${SLOT} >=kde-base/kcontrol-${PV}:${SLOT} ) >=kde-base/kdebase-${PV}:${SLOT} )
	>=kde-base/qtjava-${PV}:${SLOT}"
DEPEND=">=virtual/jdk-1.4 $COMMONDEPEND"
RDEPEND=">=virtual/jre-1.4 $COMMONDEPEND"
OLDDEPEND="~kde-base/kwin-$PV ~kde-base/kcontrol-$PV ~kde-base/qtjava-$PV virtual/jdk"

# libhpi for bug #209631
PATCHES="${FILESDIR}/no-gtk-glib-check.diff
		${FILESDIR}/${PN}-${SLOT}-javacflags.patch
		${FILESDIR}/no-libhpi.so-check.patch"

# Probably missing other kdebase, kdepim etc deps
# Needs to be compiled with just kdelibs installed to make sure

# both eclasses define pkg_setup
pkg_setup() {
	kde_pkg_setup
	java-pkg-2_pkg_setup
}

src_unpack() {
	kde-meta_src_unpack

	local cp="$(java-pkg_getjars qtjava-${SLOT})"
	local mf="${S}/kdejava/koala/org/kde/koala/Makefile.am"
	sed -i -e "s#_CLASSPATH_#${cp}#" "${mf}" \
		|| die "sed CLASSPATH failed"
	sed -i -e "s#_JAVACFLAGS_#${JAVACFLAGS}#" "${mf}" \
		|| die "sed JAVACFLAGS failed"
}

src_compile() {
	myconf="${myconf} --with-java=${JDK_HOME}"
	kde-meta_src_compile
}

src_install() {
	kde-meta_src_install

	local libdir="${D}/usr/kde/${SLOT}/$(get_libdir)"
	rm -rf "${libdir}/java" || die "rm failed"

	java-pkg_dojar "${S}/${PN}/koala/koala.jar"
	java-pkg_regso "${libdir}"/*.so
}
