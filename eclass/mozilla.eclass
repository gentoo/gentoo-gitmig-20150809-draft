# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mozilla.eclass,v 1.1 2004/08/04 23:30:43 agriffis Exp $

ECLASS=mozilla
INHERITED="$INHERITED $ECLASS"

IUSE="java gtk2 ldap debug xinerama xprint"
# Internal USE flags that I do not really want to advertise ...
IUSE="${IUSE} mozsvg moznoxft"

RDEPEND="virtual/x11
	!moznoxft ( virtual/xft )
	>=media-libs/fontconfig-2.1
	>=sys-libs/zlib-1.1.4
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.36
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	gtk2? (
		>=x11-libs/gtk+-2.2.0
		>=dev-libs/glib-2.2.0
		>=x11-libs/pango-1.2.1
		>=dev-libs/libIDL-0.8.0 )
	!gtk2? (
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2*
		>=gnome-base/ORBit-0.5.10-r1 )
	>=net-www/mozilla-launcher-1.15"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

mozilla_conf() {
	declare enable_optimize

	####################################
	#
	# CFLAGS setup and ARCH support
	#
	####################################

	# Set optimization level based on CFLAGS
	if is-flag -O0; then
		enable_optimize=-O0
	elif [[ ${ARCH} == alpha || ${ARCH} == amd64 || ${ARCH} == ia64 ]]; then
		# Anything more than this causes segfaults on startup on 64-bit
		# (bug 33767)
		enable_optimize=-O1
		append-flags -fPIC
	elif is-flag -O1; then
		enable_optimize=-O1
	else
		enable_optimize=-O2
	fi

	# Now strip optimization from CFLAGS so it doesn't end up in the
	# compile string
	filter-flags '-O*'

	# Strip over-aggressive CFLAGS - Mozilla supplies its own
	# fine-tuned CFLAGS and shouldn't be interfered with..  Do this
	# AFTER setting optimization above since strip-flags only allows
	# -O -O1 and -O2
	strip-flags

	# This was in mozilla and thunderbird but not firefox.  I'm dropping it
	# because I don't see the point in forcing it on (04 Aug 2004 agriffis)
	#append-flags -fforce-addr

	# Additional ARCH support
	case "${ARCH}" in
	alpha)
		# Mozilla won't link with X11 on alpha, for some crazy reason.
		# set it to link explicitly here.
		sed -i 's/\(EXTRA_DSO_LDOPTS += $(MOZ_GTK_LDFLAGS).*$\)/\1 -L/usr/X11R6/lib -lX11/' \
			${S}/gfx/src/gtk/Makefile.in
		;;

	ppc)
		# Fix to avoid gcc-3.3.x micompilation issues.
		if [[ $(gcc-major-version).$(gcc-minor-version) == 3.3 ]]; then
			append-flags -fno-strict-aliasing
		fi
		;;

	sparc)
		# Sparc support ...
		replace-sparc64-flags
		;;

	x86)
		if [[ $(gcc-major-version) -eq 3 ]]; then
			# gcc-3 prior to 3.2.3 doesn't work well for pentium4
			# see bug 25332
			if [[ $(gcc-minor-version) -lt 2 ||
				( $(gcc-minor-version) -eq 2 && $(gcc-micro-version) -lt 3 ) ]]
			then
				replace-flags -march=pentium4 -march=pentium3
				filter-flags -msse2
			fi
			# Enable us to use flash, etc plugins compiled with gcc-2.95.3
			myconf="${myconf} --enable-old-abi-compat-wrappers"
		fi
		;;
	esac

	# Needed to build without warnings on gcc-3
	CXXFLAGS="${CXXFLAGS} -Wno-deprecated"

	####################################
	#
	# myconf setup
	#
	####################################

	# myconf should be declared local by the caller (src_compile)
	myconf="\
		--disable-pedantic \
		--enable-crypto \
		--enable-mathml \
		--enable-optimize=${enable_optimize} \
		--enable-xsl \
		--enable-xterm-updates \
		--with-pthreads \
		--with-system-jpeg \
		--with-system-mng \
		--with-system-png \
		--with-system-zlib \
		--without-system-nspr \
		$(use_enable ipv6) \
		$(use_enable java java-supplement) \
		$(use_enable ldap) \
		$(use_enable xinerama) \
		$(use_enable xprint)"

	# NOTE: QT and XLIB toolkit seems very unstable, leave disabled until
	#       tested ok -- azarah
	if use gtk2; then
		myconf="${myconf}
			--enable-toolkit-gtk2 \
			--enable-default-toolkit=gtk2 \
			--disable-toolkit-qt \
			--disable-toolkit-xlib \
			--disable-toolkit-gtk"
	else
		myconf="${myconf}
			--enable-toolkit-gtk \
			--enable-default-toolkit=gtk \
			--disable-toolkit-qt \
			--disable-toolkit-xlib \
			--disable-toolkit-gtk2"
	fi

	if ! use debug; then
		myconf="${myconf} \
			--disable-dtd-debug \
			--disable-debug \
			--disable-tests \
			--enable-reorder \
			--enable-strip \
			--enable-strip-libs"

		# Currently --enable-elf-dynstr-gc only works for x86 and ppc,
		# thanks to Jason Wever <weeve@gentoo.org> for the fix.
		if use x86 || use ppc; then
			myconf="${myconf} --enable-elf-dynstr-gc"
		fi
	fi

	# Check if we should enable Xft support ...
	if ! use moznoxft; then
		if use gtk2; then
			local pango_version=""

			# We need Xft2.0 localy installed
			if [[ -x /usr/bin/pkg-config ]] && pkg-config xft; then
				pango_version=$(pkg-config --modversion pango | cut -d. -f1,2)

				# We also need pango-1.1, else Mozilla links to both
				# Xft1.1 *and* Xft2.0, and segfault...
				if [[ ${pango_version//.} -gt 10 ]]; then
					einfo "Building with Xft2.0 (Gtk+-2.0) support"
					myconf="${myconf} --enable-xft --disable-freetype2"
					touch ${WORKDIR}/.xft
				else
					ewarn "Building without Xft2.0 support (bad pango)"
					myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
				fi
			else
				ewarn "Building without Xft2.0 support (no pkg-config xft)"
				myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
			fi
		else
			einfo "Building with Xft2.0 (Gtk+-1.0) support"
			myconf="${myconf} --enable-xft --disable-freetype2"
			touch ${WORKDIR}/.xft
		fi
	else
		einfo "Building without Xft2.0 support (moznoxft)"
		myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
	fi

	# Re-enabled per bug 24522 (28 Apr 2004 agriffis)
	if use mozsvg; then
		export MOZ_INTERNAL_LIBART_LGPL=1
		myconf="${myconf} --enable-svg --enable-svg-renderer-libart"
	else
		myconf="${myconf} --disable-svg"
	fi
}

# Simulate the silly csh makemake script
makemake() {
	typeset m topdir

	for m in $(find . -name Makefile.in); do
		topdir=$(echo "$m" | sed -r 's:[^/]+:..:g')
		sed -e "s:@srcdir@:.:g" -e "s:@top_srcdir@:${topdir}:g" \
			< ${m} > ${m%.in} || die "sed ${m} failed"
	done
}
