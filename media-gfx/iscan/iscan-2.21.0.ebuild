# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan/iscan-2.21.0.ebuild,v 1.7 2011/03/29 12:22:06 angelos Exp $

EAPI="2"

inherit eutils flag-o-matic autotools

SRC_REV="6"  # revision used by upstream

# HINTS:
# -> non-free modules are x86 and amd64 only
# -> iscan frontend needs non-free modules
# -> sane-epkowa should be usable on every arch
# -> ${P}-${SRC_REV}.tar.gz    (for gcc 3.2/3.3)
# -> ${P}-${SRC_REV}.c2.tar.gz (for gcc 3.4 or later)

# FIXME:
# Make jpeg/png optional. The problem is, that the configure script ignores --disable-*,
# if the corresponding lib is found on the system.
# Furthermore, iscan doesn't compile w/o libusb, this should be fixed somehow.

# feel free to add your arch, every non-x86
# arch doesn't install any x86-only stuff.
KEYWORDS="amd64 x86"

DESCRIPTION="EPSON Image Scan! for Linux (including sane-epkowa backend)"
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="http://linux.avasys.jp/drivers/iscan/${PV}/${PN}_${PV}-${SRC_REV}.tar.gz"
LICENSE="GPL-2 AVASYS"
SLOT="0"

IUSE="X gimp jpeg png tiff"
IUSE_LINGUAS="de es fr it ja ko nl pt zh_CN zh_TW"

for X in ${IUSE_LINGUAS}; do IUSE="${IUSE} linguas_${X}"; done

QA_TEXTRELS="usr/$(get_libdir)/iscan/lib*"

# Upstream ships broken sanity test
RESTRICT="test"

RDEPEND="media-gfx/sane-backends
	>=sys-fs/udev-103
	>=dev-libs/libusb-0.1.12
	X? (
		x11-libs/gtk+:2
		gimp? ( media-gfx/gimp )
		png? ( media-libs/libpng )
		jpeg? ( virtual/jpeg )
		tiff? ( media-libs/tiff )
	)"

DEPEND="${RDEPEND}
	X? ( sys-devel/gettext )"

usermap_to_udev() {
	echo '# udev rules file for iscan devices (udev >= 0.98)'
	echo '#'
	echo 'ACTION!="add", GOTO="iscan_rules_end"'
	echo 'SUBSYSTEM!="usb*", GOTO="iscan_rules_end"'
	echo 'KERNEL=="lp[0-9]*", GOTO="iscan_rules_end"'
	echo

	sed -n -e '
		/^:model[[:space:]]*"[^"]/ {
			# Create model name string
			s|^:model[[:space:]]*"\([^"]\+\).*|# \1|

			# Copy to hold buffer
			h
		}
		/^:usbid[[:space:]]*"0x[[:xdigit:]]\+"[[:space:]]*"0x[[:xdigit:]]\+"/ {
			# Append next line
			N

			# Check status
			/\n:status[[:space:]]*:\(complete\|good\|untested\)/ {
				# Exchange with hold buffer
				x

				# Print (model name string)
				p

				# Exchange with hold buffer
				x

					# Create udev command string
				s|^:usbid[[:space:]]*"0x\([[:xdigit:]]\+\)"[[:space:]]*"0x\([[:xdigit:]]\+\)".*|ATTRS{idVendor}=="\1", ATTRS{idProduct}=="\2", MODE="0660", GROUP="scanner"|

				# Print (udev command string)
				p
			}
		}
	' "${1}"

	echo
	echo 'LABEL="iscan_rules_end"'
}

src_prepare() {
	local i

	# convert japanese docs to UTF-8
	if use linguas_ja; then
		for i in {NEWS,README}.ja non-free/*.ja.txt; do
			if [ -f "${i}" ]; then
				echo ">>> Converting ${i} to UTF-8"
				iconv -f eucjp -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
			fi
		done
	fi

	# disable checks for gtk+
	if ! use X; then
		sed -i -e "s:PKG_CHECK_MODULES(GTK,.*):AC_DEFINE([HAVE_GTK_2], 0):g" \
			-e "s:\(PKG_CHECK_MODULES(GDK_IMLIB,.*)\):#\1:g" configure.ac
	fi

	epatch "${FILESDIR}"/${P}-drop-ltdl.patch
	epatch "${FILESDIR}"/${P}-fix-g++-test.patch
	epatch "${FILESDIR}"/${P}-noinst-stuff.patch

	eautoreconf
}

src_configure() {
	append-flags -D_GNU_SOURCE  # needed for 'strndup'
	local myconf

	if use X; then
		myconf="--enable-frontend
			$(use_enable gimp)
			$(use_enable jpeg)
			$(use_enable png)
			$(use_enable tiff)"
	else
		myconf="--disable-frontend --disable-gimp
			--disable-jpeg --disable-png --disable-tiff"
	fi

	econf --disable-static ${myconf}
}

src_install() {
	local MY_LIB="/usr/$(get_libdir)"
	emake DESTDIR="${D}" install || die "make install failed"

	# install docs
	dodoc AUTHORS NEWS README doc/epkowa.desc
	use linguas_ja && dodoc NEWS.ja README.ja

	# remove
	rm -f "${D}usr/lib/iscan/make-udev-rules"

	# install USB hotplug stuff
	local USERMAP_FILE="doc/epkowa.desc"
	if [ -f ${USERMAP_FILE} ]; then
		dodir /etc/udev/rules.d
		usermap_to_udev ${USERMAP_FILE} \
			> "${D}etc/udev/rules.d/99-iscan.rules"
	else
		die "Can not find USB devices description file: ${USERMAP_FILE}"
	fi

	# install sane config
	insinto /etc/sane.d
	doins backend/epkowa.conf

	# link iscan so it is seen as a plugin in gimp
	if use X && use gimp; then
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
	if use X; then
		make_desktop_entry iscan "Image Scan! for Linux ${PV}" scanner
	fi
}

pkg_postinst() {
	local i
	local DLL_CONF="/etc/sane.d/dll.conf"
	local EPKOWA_CONF="/etc/sane.d/epkowa.conf"

	elog
	if grep -q "^[ \t]*\<epkowa\>" ${DLL_CONF}; then
		elog "Please edit ${EPKOWA_CONF} to suit your needs."
	elif grep -q "\<epkowa\>" ${DLL_CONF}; then
		elog "Hint: to enable the backend, add 'epkowa' to ${DLL_CONF}"
		elog "Then edit ${EPKOWA_CONF} to suit your needs."
	else
		echo "epkowa" >> ${DLL_CONF}
		elog "A new entry 'epkowa' was added to ${DLL_CONF}"
		elog "Please edit ${EPKOWA_CONF} to suit your needs."
	fi
}
