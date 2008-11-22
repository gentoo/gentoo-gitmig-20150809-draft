# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/atokx3/atokx3-1.0.0.ebuild,v 1.2 2008/11/22 02:09:06 matsuu Exp $

inherit eutils multilib

MY_PV="20.0-${PV}"
DESCRIPTION="ATOK X3 for Linux - The most famous Japanese Input Method Engine"
HOMEPAGE="http://www.justsystems.com/jp/products/atok_linux/"
SRC_URI=""

LICENSE="ATOK X11"

SLOT="0"
# bug #202356
#KEYWORDS="~amd64 ~x86"
KEYWORDS="~x86"
IUSE=""

PROPERTIES="interactive"
RESTRICT="strip mirror"

RDEPEND="!app-i18n/atokx2
	!dev-libs/libiiimcf
	!dev-libs/csconv
	!app-i18n/iiimgcf
	!dev-libs/libiiimp
	!app-i18n/iiimsf
	!app-i18n/iiimxcf
	dev-libs/atk
	dev-libs/glib
	dev-libs/libxml2
	media-libs/fontconfig
	media-libs/libpng
	x11-libs/cairo
	>=x11-libs/gtk+-2.4.13
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXxf86vm
	x11-libs/libdrm
	x11-libs/pango
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-xlibs
	)"

S="${WORKDIR}"

pkg_setup() {
	if ! cdrom_get_cds atokx3index ; then
		die "Please mount ATOK for Linux CD-ROM or set CD_ROOT variable to the directory containing ATOK X3 for Linux."
	fi
}

src_unpack() {
	local targets="
		IIIMF/iiimf-client-lib-trunk_r3104-js1.i386.tar.gz
		IIIMF/iiimf-gtk-trunk_r3104-js1.i386.tar.gz
		IIIMF/iiimf-protocol-lib-trunk_r3104-js1.i386.tar.gz
		IIIMF/iiimf-server-trunk_r3104-js1.i386.tar.gz
		IIIMF/iiimf-x-trunk_r3104-js1.i386.tar.gz
		ATOK/atokx-${MY_PV}.i386.tar.gz"
	#	IIIMF/iiimf-client-lib-devel-trunk_r3104-js1.i386.tar.gz
	#	IIIMF/iiimf-properties-trunk_r3104-js1.i386.tar.gz
	#	IIIMF/iiimf-docs-trunk_r3104-js1.i386.tar.gz
	#	IIIMF/iiimf-notuse-trunk_r3104-js1.i386.tar.gz
	#	IIIMF/iiimf-protocol-lib-devel-trunk_r3104-js1.i386.tar.gz

	if use amd64 ; then
		targets="${targets}
			IIIMF/iiimf-client-lib-64-trunk_r3104-js1.x86_64.tar.gz
			IIIMF/iiimf-gtk-64-trunk_r3104-js1.x86_64.tar.gz
			IIIMF/iiimf-protocol-lib-64-trunk_r3104-js1.x86_64.tar.gz
			ATOK/atokx-64-${MY_PV}.x86_64.tar.gz"
		#	IIIMF/iiimf-client-lib-devel-64-trunk_r3104-js1.x86_64.tar.gz
		#	IIIMF/iiimf-protocol-lib-devel-64-trunk_r3104-js1.x86_64.tar.gz
		#	IIIMF/iiimf-notuse-64-trunk_r3104-js1.x86_64.tar.gz
	fi

	for i in ${targets}
	do
		einfo "unpack ${i}"
		tar xzf "${CDROM_ROOT}"/bin/tarball/${i} || die "Failed to unpack ${i}"
	done

	if use amd64 ; then
		lib32="$(ABI=x86 get_libdir)"
		lib64="$(get_libdir)"
		if [ "lib" != "${lib32}" ] ; then
			mv usr/lib usr/${lib32} || die
		fi
		if [ "lib64" != "${lib64}" ] ; then
			mv usr/lib64 usr/${lib64} || die
		fi
	fi
}

src_install() {

	cp -dpR * "${D}" || die

	# amd64 hack
	if use amd64 ; then
		if [ "$(ABI=x86 get_libdir)" != "$(get_libdir)" ] ; then
			dosym /usr/$(ABI=x86 get_libdir)/iiim /usr/$(get_libdir)/iiim || die
		fi
	fi

	dodoc "${CDROM_ROOT}"/doc/atok.pdf || die
	dohtml "${CDROM_ROOT}"/readme.html || die
}

get_gtk_confdir() {
	if useq amd64 || ( [ "${CONF_LIBDIR}" == "lib32" ] && useq x86 ) ; then
		echo "/etc/gtk-2.0/${CHOST}"
	else
		echo "/etc/gtk-2.0"
	fi
}

pkg_postinst() {
	elog
	elog "To use ATOK for Linux, you need to add following to .xinitrc or .xprofile:"
	elog
	elog ". /opt/atokx3/bin/atokx3start.sh"
	elog
	gtk-query-immodules-2.0 > "${ROOT}/$(get_gtk_confdir)/gtk.immodules"
}

pkg_postrm() {
	gtk-query-immodules-2.0 > "${ROOT}/$(get_gtk_confdir)/gtk.immodules"
}
