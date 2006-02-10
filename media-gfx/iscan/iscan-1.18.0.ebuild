# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan/iscan-1.18.0.ebuild,v 1.1 2006/02/10 20:18:56 sbriesen Exp $

inherit eutils multilib toolchain-funcs

SRC_GCC33="${P}-1.tar.gz"
SRC_GCC34="${P}-1.c2.tar.gz"

DESCRIPTION="EPSON Image Scan! for Linux (including sane-epkowa backend)"
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="http://lx1.avasys.jp/iscan/v${PV//./}/${SRC_GCC33}
	http://lx1.avasys.jp/iscan/v${PV//./}/${SRC_GCC34}"
LICENSE="GPL-2 x86? ( EAPL EPSON )"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="X gimp unicode"

# HINTS:
# -> non-free modules are x86 only
# -> isane frontend needs non-free modules
# -> sane-epkowa should be usable on every arch
# -> ${P}-1.tar.gz    (for gcc 3.2/3.3)
# -> ${P}-1.c2.tar.gz (for gcc 3.4 or later)

# FIXME:
# make jpeg/png optional. Problem is, that the
# configure script ignores --disable-*, if the
# corresponding lib is found on the system.

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

	# Select correct tarball for installed GCC. This is not a perfect
	# solution and should be expanded to other working GCC versions.
	einfo "GCC version: $(gcc-fullversion)"
	case "$(gcc-version)" in
		3.[23])
			MY_A="${SRC_GCC33}";;
		3.4)
			MY_A="${SRC_GCC34}";;
		*)
			if use x86; then
				die "Your GCC version is not supported. You need either 3.2, 3.3 or 3.4!"
			else
				MY_A="${SRC_GCC34}"  # fallback to GCC 3.4, should not harm.
			fi;;
	esac
}

src_unpack() {
	unpack "${MY_A}"
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

pkg_postinst() {
	einfo
	einfo "Hint: to enable the backend, add 'epkowa' in /etc/sane.d/dll.conf"
	einfo "Then edit /etc/sane.d/epkowa.conf to suit your needs."
	einfo
}
