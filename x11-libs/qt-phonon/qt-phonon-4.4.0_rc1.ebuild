# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-phonon/qt-phonon-4.4.0_rc1.ebuild,v 1.6 2007/12/22 17:46:11 caleb Exp $

inherit qt4-build

SRCTYPE="preview-opensource-src"
DESCRIPTION="The Phonon module for the Qt toolkit."
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_rc/-tp}

SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.gz"
S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="~x86"

IUSE="dbus"

RDEPEND="~x11-libs/qt-gui-${PV}
	media-libs/gstreamer
	media-libs/gst-plugins-base
	dbus? ( =x11-libs/qt-dbus-${PV} )"

DEPEND="${RDEPEND}"

QT4_TARGET_DIRECTORIES="src/phonon src/plugins/phonon"

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/abstractaudiooutput.cpp.diff

	# Don't let the user go too overboard with flags.  If you really want to, uncomment
	# out the line below and give 'er a whirl.
	strip-flags
	replace-flags -O3 -O2

	if [[ $( gcc-fullversion ) == "3.4.6" && gcc-specs-ssp ]] ; then
		ewarn "Appending -fno-stack-protector to CFLAGS/CXXFLAGS"
		append-flags -fno-stack-protector
	fi

	skip_qmake_build_patch
	skip_project_generation_patch
	install_binaries_to_buildtree
}

src_compile() {
	local myconf=$(standard_configure_options)

	myconf="${myconf} -phonon"
	use dbus	&& myconf="${myconf} -qdbus" || myconf="${myconf} -no-qdbus"

	echo ./configure ${myconf}
	./configure ${myconf} || die

	build_target_directories
}

pkg_postinst()
{
	qconfig_add_option phonon
}

pkg_postrm()
{
	qconfig_remove_option phonon
}
