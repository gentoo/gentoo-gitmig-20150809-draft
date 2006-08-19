# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kaffe/kaffe-1.1.6-r2.ebuild,v 1.9 2006/08/19 14:38:19 tcort Exp $

inherit base eutils java flag-o-matic

DESCRIPTION="A cleanroom, open source Java VM and class libraries"
SRC_URI="http://www.kaffe.org/ftp/pub/kaffe/v1.1.x-development/${P/_/-}.tar.gz
		 mirror://gentoo/${P}-kaffeh.patch.bz2"
HOMEPAGE="http://www.kaffe.org/"

#robilad recommended in bug 103978 that we leave the X and QT
#awt backends disabled for now. Please check the status of these
#backends with new upstream versions.
#	X?( virtual/x11 )
#	qt?( =x11-libs/qt-3.3* )

DEPEND="
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	app-arch/zip
	dev-java/jikes
	dev-libs/libxml2
	sys-libs/zlib
	gtk? (
		>=dev-libs/glib-2.0
		>=x11-libs/gtk+-2.0
		>=media-libs/libart_lgpl-2.0 )
	esd? ( >=media-sound/esound-0.2.1 )
	alsa? ( >=media-libs/alsa-lib-1.0.1 )
	gmp? ( >=dev-libs/gmp-3.1 )"
RDEPEND=${DEPEND}

# We need to build this after kaffe because it is implemented in java
PDEPEND="dev-java/gjdoc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
#X qt
IUSE="alsa esd gmp gtk nls"

# ${P}-alsa is needed to prevent compile errors with newer alsas
#	(see bug #119272)
PATCHES="${DISTDIR}/${P}-kaffeh.patch.bz2 ${FILESDIR}/${P}-alsa.patch"

pkg_setup() {
	if ! use gmp; then
		ewarn "You have don't have the gmp use flag set."
		ewarn "Using gmp is the default upstream setting."
		epause 3
	fi

	if ! use gtk; then
		ewarn ""
		ewarn "The gtk use flag is needed for a awt implementation."
		ewarn "Don't file bugs for awt not working when you have"
		ewarn "gtk use flag turned off."
		epause 3
	fi
}

src_compile() {
	local confargs=""

	# see #88330
	strip-flags "-fomit-frame-pointer"

	if ! use alsa && ! use esd; then
		confargs="${confargs} --disable-sound"
	fi

	! use gmp && confargs="${confargs} --enable-pure-java-math"

#		$(use_with X x) \
#		$(use_with X kaffe-x-awt) \
#		$(use_with qt kaffe-qt-awt ) \

	# according to dalibor, this is needed on ppc because jit is
	# not complete
	# TODO needs testing!
	use ppc && confargs="${confargs} --with-engine=intrp"

	# --with-rt-jar in 1.1.7 to use the system installed classpath
	./configure \
		--disable-dependency-tracking \
		--prefix=/opt/${P} \
		--host=${CHOST} \
		$(use_with alsa)\
		$(use_with esd) \
		$(use_with gmp) \
		$(use_enable nls) \
		$(use_with gtk classpath-gtk-awt) \
		${confargs} \
		--with-jikes \
		--disable-gjdoc || die "Failed to configure."

	# --with-bcel
	# --with-profiling
	make || die "Failed to compile"
}

src_install() {
	make DESTDIR=${D} install || die "Failed to install"
	set_java_env ${FILESDIR}/${VMHANDLE} || die "Failed to install environment files"

	local javadoc=${D}/opt/${P}/bin/javadoc
	# xno append here to zero the kaffe installed one
	echo '#!/bin/bash' > ${javadoc}
	echo 'exec /usr/bin/gjdoc "${@}"' >> ${javadoc}
}

pkg_postinst() {
	ewarn "Please, do not use Kaffe as your default JDK/JRE!"
	ewarn "Kaffe is currently meant for testing... it should be"
	ewarn "only be used by developers or bug-hunters willing to deal"
	ewarn "with oddities that are bound to come up while using Kaffe!"
}
