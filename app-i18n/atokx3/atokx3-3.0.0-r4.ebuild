# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/atokx3/atokx3-3.0.0-r4.ebuild,v 1.1 2009/11/24 14:46:46 matsuu Exp $

inherit eutils multilib

DESCRIPTION="ATOK X3 for Linux - The most famous Japanese Input Method Engine"
HOMEPAGE="http://www.justsystems.com/jp/products/atok_linux/"
SRC_URI="http://www3.justsystem.co.jp/download/atok/up/lin/${PN}up2.tar.gz
	http://www3.justsystem.co.jp/download/atok/up/lin/${PN}gtk216.tar.gz
	http://www3.justsystem.co.jp/download/zipcode/up/lin/a20y0911lx.tgz"

LICENSE="ATOK X11"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PROPERTIES="interactive"
RESTRICT="strip mirror binchecks"
#FEATURES="${FEATURES/multilib-strict}"

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
	sys-apps/tcp-wrappers
	sys-libs/pam
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
	if has_multilib_profile ; then
		GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	fi
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}

	if ! cdrom_get_cds atokx3index ; then
		die "Please mount ATOK for Linux CD-ROM or set CD_ROOT variable to the directory containing ATOK X3 for Linux."
	fi
	if use amd64 && [ ! -f "/$(ABI=x86 get_libdir)/libwrap.so" ] ; then
		TCPD_PF="$(best_version sys-apps/tcp-wrappers)"
		eerror "${PN} requires /$(ABI=x86 get_libdir)/libwrap.so to work on amd64."
		eerror "# emerge crossdev"
		eerror "# crossdev --target i686-pc-linux-gnu-gcc"
		eerror "# CC=i686-pc-linux-gnu-gcc ABI=x86 emerge -B1 '=${TCPD_PF}'"
		eerror "# tar xpvf ${PKGDIR}/${TCPD_PF}.tbz2 -C / ./$(ABI=x86 get_libdir) ./usr/$(ABI=x86 get_libdir)"
		die
	fi
}

src_unpack() {
	local targets="
		IIIMF/iiimf-client-lib-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-gtk-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-protocol-lib-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-server-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-x-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-client-lib-devel-trunk_r3104-js*.i386.tar.gz
		IIIMF/iiimf-protocol-lib-devel-trunk_r3104-js*.i386.tar.gz
		ATOK/atokx-20.0-*.0.0.i386.tar.gz"
	#	IIIMF/iiimf-properties-trunk_r3104-js*.i386.tar.gz
	#	IIIMF/iiimf-docs-trunk_r3104-js*.i386.tar.gz
	#	IIIMF/iiimf-notuse-trunk_r3104-js*.i386.tar.gz

	if use amd64 ; then
		targets="${targets}
			IIIMF/iiimf-client-lib-64-trunk_r3104-js*.x86_64.tar.gz
			IIIMF/iiimf-gtk-64-trunk_r3104-js*.x86_64.tar.gz
			IIIMF/iiimf-protocol-lib-64-trunk_r3104-js*.x86_64.tar.gz
			ATOK/atokx-64-20.0-*.0.0.x86_64.tar.gz"
		#	IIIMF/iiimf-client-lib-devel-64-trunk_r3104-js*.x86_64.tar.gz
		#	IIIMF/iiimf-protocol-lib-devel-64-trunk_r3104-js*.x86_64.tar.gz
		#	IIIMF/iiimf-notuse-64-trunk_r3104-js*.x86_64.tar.gz
	fi

	targets="${targets} ATOK/atokxup-20.0-*.0.0.i386.tar.gz"

	unpack ${PN}up2.tar.gz

	for i in ${targets}
	do
		if [ -f "${S}"/atokx3up2/bin/${i} ] ; then
			einfo "unpack" $(basename "${S}"/atokx3up2/bin/${i})
			tar xzf "${S}"/atokx3up2/bin/${i} || die "Failed to unpack ${i}"
		elif [ -f "${CDROM_ROOT}"/bin/tarball/${i} ] ; then
			einfo "unpack" $(basename "${CDROM_ROOT}"/bin/tarball/${i})
			tar xzf "${CDROM_ROOT}"/bin/tarball/${i} || die "Failed to unpack ${i}"
		else
			eerror "${i} not found."
			die "${i} not found."
		fi
	done
	unpack ${PN}gtk216.tar.gz
	unpack a20y0911lx.tgz

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
	dodoc atokx3up2/README_UP2.txt
	# atokx3up2
	rm -rf atokx3up2

	cp -dpR * "${D}" || die

	# amd64 hack
	if use amd64 ; then
		if [ "$(ABI=x86 get_libdir)" != "$(get_libdir)" ] ; then
			dosym /usr/$(ABI=x86 get_libdir)/iiim /usr/$(get_libdir)/iiim || die
			dosym /usr/$(ABI=x86 get_libdir)/libiiimcf.la /usr/$(get_libdir)/libiiimcf.la || die
			dosym /usr/$(ABI=x86 get_libdir)/libiiimp.la /usr/$(get_libdir)/libiiimp.la || die
		fi
	fi

	dodoc "${CDROM_ROOT}"/doc/atok.pdf || die
	dohtml "${CDROM_ROOT}"/readme.html || die
}

pkg_postinst() {
	elog
	elog "To use ATOK for Linux, you need to add following to .xinitrc or .xprofile:"
	elog
	elog ". /opt/atokx3/bin/atokx3start.sh"
	elog
	[ "${ROOT}" == "/" ] && gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
}

pkg_postrm() {
	[ "${ROOT}" == "/" ] && gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
}
