# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-core/qt-core-4.4.0_rc1.ebuild,v 1.3 2007/12/22 16:30:25 caleb Exp $

inherit qt4-build

SRCTYPE="preview-opensource-src"
DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_rc/-tp}

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.gz"
S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="~x86"

IUSE="glib qt3support ssl"

RDEPEND="ssl? ( dev-libs/openssl )
	sys-libs/zlib
	glib? ( dev-libs/glib )" 	# Used in QtNetwork module

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!=x11-libs/qt-4.3*
	!=x11-libs/qt-4.2*
	!=x11-libs/qt-4.1*
	!=x11-libs/qt-4.0*"

QT4_TARGET_DIRECTORIES="src/tools/moc src/tools/rcc src/tools/uic src/corelib src/xml src/network"

src_unpack() {
	qt4-build_src_unpack
}

src_compile() {
	unset QMAKESPEC
	local myconf=$(standard_configure_options)

	use ssl		&& myconf="${myconf} -openssl" || myconf="${myconf} -no-openssl"
	use glib		&& myconf="${myconf} -glib" || myconf="${myconf} -no-glib"
	use qt3support	&& myconf="${myconf} -qt3support" || myconf="${myconf} -no-qt3support"

	myconf="${myconf} -no-xkb -no-tablet -no-fontconfig -no-xrender -no-xrandr -no-xfixes -no-xcursor \
	-no-xinerama -no-xshape -no-sm -no-opengl -no-nas-sound -no-qdbus -iconv -no-cups -no-nis \
	-no-gif -no-libpng -no-libmng -no-libjpeg -no-openssl -system-zlib -no-webkit -no-phonon \
	-no-xmlpatterns -no-freetype -no-libtiff  -no-accessibility -no-fontconfig -no-glib -no-opengl ${myconf}"

	echo ./configure ${myconf}
	./configure ${myconf} || die

	build_target_directories
}

src_install() {
	dobin "${S}"/bin/qmake
	dobin "${S}"/bin/moc
	dobin "${S}"/bin/rcc
	dobin "${S}"/bin/uic

	install_directories src/corelib src/xml src/network

	# TODO: don't override qconfig.pri when a new fresh set of options if there are some already installed on the system
	cd "${S}" && emake INSTALL_ROOT="${D}" install_mkspecs || die

	fix_library_files

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
	libdirs="${libdirs}:/usr/${libdir}/qt4"
	done

	cat > "${T}/44qt4" << EOF
LDPATH=${libdirs:1}
EOF

	doenvd "${T}/44qt4"
}

pkg_setup() {
	qt4-build_pkg_setup

	if has_version x11-libs/qt-core; then

		# Check to see if they've changed the glib flag since the last time installing this package.

		if use glib && ! built_with_use x11-libs/qt-core glib && has_version x11-libs/qt-gui; then
			ewarn "You have changed the \"glib\" use flag since the last time you have emerged this package."
			ewarn "You should also re-emerge x11-libs/qt-gui in order for it to pick up this change."
		elif ! use glib && built_with_use x11-libs/qt-core glib && has_version x11-libs/qt-gui; then
			ewarn "You have changed the \"glib\" use flag since the last time you have emerged this package."
			ewarn "You should also re-emerge x11-libs/qt-gui in order for it to pick up this change."
		fi

		# Check to see if they've changed the qt3support flag since the last time installing this package.
		# If so, give a list of packages they need to un-emerge first.

		if use qt3support && ! built_with_use x11-libs/qt-core qt3support; then
			local need_to_remove="";
			ewarn "You have changed the \"qt3support\" use flag since the last time you have emerged this package."
			for x in sql opengl gui qt3support; do
				local pkg="x11-libs/qt-${x}"
				if has_version $pkg; then
					need_to_remove="${need_to_remove} ${pkg}"
				fi
			done
			if [ -n "${need_to_remove}" ]; then
				die "You must first un-emerge these packages before continuing: \n\t\t${need_to_remove}"
			fi
		elif ! use qt3support && built_with_use x11-libs/qt-core qt3support; then
			local need_to_remove="";
			ewarn "You have changed the \"qt3support\" use flag since the last time you have emerged this package."
			for x in sql opengl gui qt3support; do
				local pkg="x11-libs/qt-${x}"
				if has_version $pkg; then
					need_to_remove="${need_to_remove} ${pkg}"
				fi
			done
			if [ -n "${need_to_remove}" ]; then
				die "You must first un-emerge these packages before continuing: \n\t\t${need_to_remove}"
			fi
		fi
	fi
}
