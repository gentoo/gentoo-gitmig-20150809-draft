# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan/iscan-2.0.0-r1.ebuild,v 1.2 2006/04/16 11:16:36 sbriesen Exp $

inherit eutils multilib toolchain-funcs autotools rpm

# HINTS:
# -> non-free modules are x86 only
# -> isane frontend needs non-free modules
# -> sane-epkowa should be usable on every arch
# -> ${P}-0.tar.gz    (for gcc 3.2/3.3)
# -> ${P}-0.c2.tar.gz (for gcc 3.4 or later)

# PLUGINS:
# -> iscan-plugin-gt-7200 == Perfection 1250 PHOTO
# -> iscan-plugin-gt-7300 == Perfection 1260 PHOTO
# -> iscan-plugin-gt-9400 == Perfection 3170 PHOTO      (esfw32.bin)
# -> iscan-plugin-gt-f500 == Perfection 2480/2580 PHOTO (esfw41.bin)
# -> iscan-plugin-gt-f520 == Perfection 3490/3590 PHOTO (esfw52.bin)
# -> iscan-plugin-gt-f600 == Perfection 4180 PHOTO      (esfw43.bin)
# -> iscan-plugin-gt-x750 == Perfection 4490 PHOTO      (esfw54.bin)

# FIXME:
# Make jpeg/png optional. The problem is, that the
# configure script ignores --disable-*, if the
# corresponding lib is found on the system.
# Furthermore, isane doesn't compile w/o libusb,
# this should be fixed somehow.

LANGS="de es fr it ja ko nl pt zh_CN zh_TW"
PLUGINS="7200 7300 9400 f500 f520 f600 x750"

FIRMWARE=(	"esfw41.bin Perfection 2480/2580 PHOTO"
			"esfw32.bin Perfection 3170 PHOTO"
			"esfw52.bin Perfection 3490/3590 PHOTO"
			"esfw43.bin Perfection 4180 PHOTO"
			"esfw54.bin Perfection 4490 PHOTO" )

SRC_GCC33="http://lx1.avasys.jp/iscan/${PV}/${P}-0.tar.gz"
SRC_GCC34="http://lx1.avasys.jp/iscan/${PV}/${P}-0.c2.tar.gz"
BIN_GCC33=""
BIN_GCC34=""

for X in ${PLUGINS}; do
	BIN_GCC33="${BIN_GCC33}	http://lx1.avasys.jp/iscan/v1180/iscan-plugin-gt-${X}-1.0.0-1.i386.rpm"
	BIN_GCC34="${BIN_GCC34}	http://lx1.avasys.jp/iscan/v1180/iscan-plugin-gt-${X}-1.0.0-1.c2.i386.rpm"
done

# feel free to add your arch, every non-x86
# arch doesn't install any x86-only stuff.
KEYWORDS="~amd64 ~x86"

DESCRIPTION="EPSON Image Scan! for Linux (including sane-epkowa backend and firmware)"
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="x86? ( ${SRC_GCC33} ${BIN_GCC33} ) ${SRC_GCC34} ${BIN_GCC34}"
LICENSE="GPL-2 EAPL EPSON"
SLOT="0"

IUSE="X gimp unicode udev"
for X in ${LANGS}; do IUSE="${IUSE} linguas_${X}"; done

DEPEND="media-gfx/sane-backends
	media-libs/libpng
	media-libs/jpeg
	!udev? (
		sys-apps/hotplug
	)
	>=dev-libs/libusb-0.1.6
	x86? (
		X? (
			sys-devel/gettext
			>=x11-libs/gtk+-2.0
			gimp? ( media-gfx/gimp )
		)
	)"

snapscan_firmware() {
	local i
	echo "#-------------- EPSON Image Scan! for Linux Scanner-Firmware --------------"
	for i in "${FIRMWARE[@]}"; do
		echo
		echo "# ${i#* } (${i%% *})"
		echo "#firmware /usr/share/iscan/${i%% *}"
	done
	echo
	cat 2>/dev/null "${1}"
}

usermap_to_udev() {
	local DEVICE='\1SYSFS{idVendor}=="\L\2\E", SYSFS{idProduct}=="\L\3\E"'
	local ACTION='MODE="0660", GROUP="scanner", RUN+="/lib/udev/iscan-usb.sh"'
	echo 'SUBSYSTEM!="usb_device", ACTION!="add", GOTO="iscan_rules_end"'
	echo
	sed -n -e "s|^\(# SEIKO EPSON.*\)|\1|p" \
		-e "s|^\(#*\)i*scan-device *0x0003 *0x\([^ ]\+\) *0x\([^ ]\+\)*.*|${DEVICE}, ${ACTION}|p" "${1}"
	echo
	echo 'LABEL="iscan_rules_end"'
}

pkg_setup() {
	local i
	if ! use x86 && ( use X || use gimp ); then
		ewarn
		ewarn "The iscan application needs CSS x86-only libs and"
		ewarn "thus can't be built currently. You can still use"
		ewarn "'xscanimage', 'xsane' or 'kooka' with sane-epkowa"
		ewarn "backend. But some low-end scanners are also not"
		ewarn "supported, because they need these x86 libs, too."
		ewarn
	fi

	# Select correct tarball for installed GCC. This is not a perfect
	# solution and should be expanded to other working GCC versions.
	einfo "GCC version: $(gcc-fullversion)"
	case "$(gcc-version)" in
		3.[23])
			if use x86; then
				MY_A="${SRC_GCC33##*/}"
				for i in ${BIN_GCC33}; do MY_A="${MY_A} ${i##*/}"; done
			else  # fallback to GCC 3.4, should not harm.
				MY_A="${SRC_GCC34##*/}"
				for i in ${BIN_GCC34}; do MY_A="${MY_A} ${i##*/}"; done
			fi
			;;
		3.4|4.[012])  # 4.x seems to work (tested with Perfection 3490 PHOTO)
			MY_A="${SRC_GCC34##*/}"
			for i in ${BIN_GCC34}; do MY_A="${MY_A} ${i##*/}"; done
			;;
		*)
			if use x86; then
				die "Your GCC version is not supported. You need either 3.2, 3.3, 3.4 or 4.x!"
			else
				MY_A="${SRC_GCC34##*/}"  # fallback to GCC 3.4, should not harm.
				for i in ${BIN_GCC34}; do MY_A="${MY_A} ${i##*/}"; done
			fi
			;;
	esac
}

src_unpack() {
	local i

	cd "${WORKDIR}"
	for i in ${MY_A}; do
		case "${i}" in
			*.rpm)
				echo ">>> Unpacking ${i}"
				rpm_unpack "${DISTDIR}/${i}" || die "failure unpacking ${i}"
				;;
			*)
				unpack "${i}"
				;;
		esac
	done

	cd "${S}"

	# convert japanese docs to UTF-8
	if use unicode && use linguas_ja; then
		einfo "Converting docs to UTF-8"
		for i in {NEWS,README}.ja non-free/*.ja.txt; do
			if [ -f "${i}" ]; then
				iconv -f eucjp -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
			fi
		done
	fi

	# disable iscan frontend + none-free modules
	if ! ( use x86 && use X ); then
		sed -i -e "s:PKG_CHECK_MODULES(GTK,.*):AC_DEFINE([HAVE_GTK_2], 0):g" \
			-e "s:\(PKG_CHECK_MODULES(GDK_IMLIB,.*)\):#\1:g" configure.ac
		sed -i -e 's:^\([[:space:]]*\)frontend[[:space:]]*\\:\1\\:g' \
			-e 's:^\([[:space:]]*\)non-free[[:space:]]*\\:\1\\:g' \
			-e 's:^\([[:space:]]*\)po[[:space:]]*\\:\1\\:g' Makefile*
		sed -i -e 's:iscan.1::g' doc/Makefile*
	fi
}

src_compile() {
	eautoconf
	econf --enable-jpeg --enable-png --with-pic || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	local MY_LIB="/usr/$(get_libdir)"
	make DESTDIR="${D}" install || die "make install failed"

	# --disable-static doesn't work, so we just remove obsolete static lib
	sed -i -e "s:^\(old_library=\):# \1:g" "${D}${MY_LIB}/sane/libsane-epkowa.la"
	rm -f "${D}${MY_LIB}/sane/libsane-epkowa.a"

	# install scanner plugins (x86-only)
	if use x86; then
		dodir ${MY_LIB}/iscan
		cp -df "${WORKDIR}"/usr/lib/iscan/* "${D}${MY_LIB}"/iscan/.
	fi

	# install scanner firmware (could be used by sane-backends)
	insinto /usr/share/iscan
	doins "${WORKDIR}"/usr/share/iscan/*

	# install docs
	dodoc AUTHORS NEWS README doc/epkowa.desc
	use linguas_ja && dodoc NEWS.ja README.ja

	# install USB hotplug stuff
	if use udev; then
		dodir /etc/udev/rules.d
		usermap_to_udev utils/hotplug/iscan.usermap \
			> "${D}etc/udev/rules.d/75-iscan.rules"
		exeinto /lib/udev
		doexe ${FILESDIR}/iscan-usb.sh
	else
		insinto /etc/hotplug/usb
		exeinto /etc/hotplug/usb
		doins utils/hotplug/iscan.usermap
		doexe utils/hotplug/iscan-device
	fi

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
	local i
	local DLL_CONF="/etc/sane.d/dll.conf"
	local EPKOWA_CONF="/etc/sane.d/epkowa.conf"
	local SNAPSCAN_CONF="/etc/sane.d/snapscan.conf"
	einfo
	if grep -q "^[ \t]*\<epkowa\>" ${DLL_CONF}; then
		einfo "Please edit ${EPKOWA_CONF} to suit your needs."
	elif grep -q "\<epkowa\>" ${DLL_CONF}; then
		einfo "Hint: to enable the backend, add 'epkowa' to ${DLL_CONF}"
		einfo "Then edit ${EPKOWA_CONF} to suit your needs."
	else
		echo "epkowa" >> ${DLL_CONF}
		einfo "A new entry 'epkowa' was added to ${DLL_CONF}"
		einfo "Please edit ${EPKOWA_CONF} to suit your needs."
	fi
	einfo
	einfo "You can also use the 'snapscan' backend if you have a recent"
	einfo "sane-backend installation. Firmware files for some newer"
	einfo "EPSON scanners were installed into /usr/share/iscan:"
	einfo
	for i in "${FIRMWARE[@]}"; do
		einfo " ${i%% *}: ${i#* }"
	done
	einfo
	if ! grep 2>/dev/null -q "/usr/share/iscan/.*\.bin" "${SNAPSCAN_CONF}"; then
		snapscan_firmware "${SNAPSCAN_CONF}" > "${SNAPSCAN_CONF}~~~" \
		&& mv -f "${SNAPSCAN_CONF}~~~" "${SNAPSCAN_CONF}" \
		|| rm -f "${SNAPSCAN_CONF}~~~"
		einfo "The firmware entries were added to ${SNAPSCAN_CONF}"
	else
		einfo "Please edit ${SNAPSCAN_CONF} to suit your needs."
	fi
	einfo "Hint: not all models are supported by 'snapscan' yet!"
	einfo
	einfo "You can check which backend fits best for your scanner:"
	einfo "http://sane-project.org/cgi-bin/driver.pl?manu=Epson&bus=any"
	einfo
}
