# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan/iscan-1.17.0.ebuild,v 1.1 2005/11/24 23:50:53 sbriesen Exp $

inherit eutils multilib

DESCRIPTION="EPSON Image Scan! for Linux (including sane-epkowa backend)"
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="http://lx1.avasys.jp/iscan/v${PV//./}/${P}-1.c2.tar.gz"
LICENSE="GPL-2 x86? ( EAPL EPSON )"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="X gimp unicode"

# -> non-free modules are x86 only
# -> isane frontend needs non-free modules
# -> sane-epkowa should be usable on every arch

DEPEND=">=dev-libs/libusb-0.1.6
	media-gfx/sane-backends
	media-libs/libpng
	media-libs/jpeg
	x86? (
		X? (
			sys-devel/gettext
			>=x11-libs/gtk+-2.0
			gimp? ( media-gfx/gimp )
		)
	)"

pkg_setup() {
	if ! use x86 && use X; then
		ewarn "The iscan application needs CSS x86-only libs and"
		ewarn "thus can't be built currently. You can still use"
		ewarn "'xscanimage', 'xsane' or 'kooka' with sane-epkowa"
		ewarn "backend. But some low-end scanners are also not"
		ewarn "supported, because they need these x86 libs, too."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use unicode; then
		einfo "Converting docs to UTF-8"
		for i in {NEWS,README}.ja non-free/{EAPL,LICENSE.EPSON}.ja.txt; do
			iconv -f eucjp -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi

	if ! ( use x86 && use X ); then  # disable iscan frontend
		sed -i -e 's:^\([[:space:]]\)frontend[[:space:]]*\\:\1\\:g' \
			-e 's:^\([[:space:]]\)po[[:space:]]*\\:\1\\:g' Makefile.in
		sed -i -e 's:iscan.1::g' doc/Makefile.in
	fi

	if ! use x86; then  # disable non-free modules (x86-only)
		sed -i -e 's:^\([[:space:]]\)non-free[[:space:]]*\\:\1\\:g' Makefile.in
	fi
}

src_compile() {
	econf --enable-jpeg --enable-png --with-pic || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# --disable-static doesn't work, so we just remove static lib
	rm -f "${D}/usr/$(get_libdir)/sane/libsane-epkowa.a"

	# install docs
	dodoc AUTHORS {NEWS,README}*

	# install hotplug stuff	
	insinto /etc/hotplug/usb
	exeinto /etc/hotplug/usb
	doins utils/hotplug/iscan.usermap
	doexe utils/hotplug/iscan-device

	# install sane config
	insinto /etc/sane.d
	doins backend/epkowa.conf

	# link iscan so it is seen as a plugin in gimp
	if use x86 && use X && use gimp; then
		local plugindir
		if [ -x /usr/bin/gimptool ]; then
			plugindir="$(gimptool --gimpplugindir)/plug-ins"
		elif [ -x /usr/bin/gimptool-2.0 ]; then
			plugindir="$(gimptool-2.0 --gimpplugindir)/plug-ins"
		else
			die "Can't find GIMP plugin directory."
		fi
		dodir "${plugindir}"
		dosym /usr/bin/iscan "${plugindir}"
	fi

	# install desktop entry
	if use x86 && use X; then
		make_desktop_entry iscan "Image Scan! for Linux ${PV}" scanner.png
	fi
}
