# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-0.7.1.ebuild,v 1.5 2004/08/03 21:21:36 gustavoz Exp $

IUSE="crypt debug gtk2 ipv6 ldap xinerama"

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic gcc eutils nsplugins mozilla-launcher

EMVER="0.84.2"
IPCVER="1.0.7"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}/thunderbird-${PV}-source.tar.bz2
	 crypt? ( http://downloads.mozdev.org/enigmail/src/enigmail-${EMVER}.tar.gz
	   		  http://downloads.mozdev.org/enigmail/src/ipc-${IPCVER}.tar.gz )"

KEYWORDS="x86 ~ppc sparc ~alpha ~amd64 ia64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

RDEPEND="virtual/x11
	virtual/xft
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
		>=dev-libs/libIDL-0.8.0 )
	!gtk2? (
		=x11-libs/gtk+-1.2*
		>=gnome-base/ORBit-0.5.10-r1 )
	crypt? ( >=app-crypt/gnupg-1.2.1 )
	>=net-www/mozilla-launcher-1.7-r1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_THUNDERBIRD=1
export MOZ_ENABLE_XFT=1

# Simulate the silly csh makemake script
makemake() {
	typeset m topdir

	for m in $(find . -name Makefile.in); do
		topdir=$(echo "$m" | sed -r 's:[^/]+:..:g')
		sed -e "s:@srcdir@:.:g" -e "s:@top_srcdir@:${topdir}:g" \
			< ${m} > ${m%.in} || die "sed ${m} failed"
	done
}

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die

	# Unpack the enigmail plugin
	if use crypt; then
		for x in ipc enigmail; do
			mv ${WORKDIR}/${x} ${S}/extensions || die
			cd ${S}/extensions/${x} || die
			makemake	# see function above
		done
	fi
}

src_compile() {
	####################################
	#
	# myconf setup
	#
	####################################

	local myconf

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
#			--enable-cpp-rtti"

		# Currently --enable-elf-dynstr-gc only works for x86 and ppc,
		# thanks to Jason Wever <weeve@gentoo.org> for the fix.
		if use x86 || use ppc; then
			myconf="${myconf} --enable-elf-dynstr-gc"
		fi
	fi

	####################################
	#
	# CFLAGS setup and ARCH support
	#
	####################################

	local enable_optimize

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

	# Who added the following line and why?  It doesn't really hurt
	# anything, but is it necessary??  (28 Apr 2004 agriffis)
	append-flags -fforce-addr

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
	#  Configure and build Thunderbird
	#
	####################################

	cd ${S}
	einfo "Configuring Thunderbird..."
	econf \
		--with-x \
		--with-system-jpeg \
		--with-system-mng \
		--with-system-png \
		--with-system-zlib \
		--enable-xft \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		--disable-calendar \
		$(use_enable xinerama) \
		--disable-pedantic \
		--disable-svg \
		--enable-mathml \
		--without-system-nspr \
		--enable-nspr-autoconf \
		--enable-xsl \
		--enable-crypto \
		--enable-extensions=wallet,spellcheck \
		--enable-optimize="${enable_optimize}" \
		--with-default-mozilla-five-home=/usr/lib/MozillaThunderbird \
		--with-pthreads \
		--with-user-appdir=.thunderbird \
		--disable-jsd \
		--disable-accessibility \
		--disable-profilesharing \
		--disable-necko-disk-cache \
		--disable-activex-scripting \
		--disable-installer \
		--disable-activex \
		--disable-logging \
		--enable-xterm-updates \
		--enable-necko-protocols=http,file,jar,viewsource,res,data \
		--enable-image-decoders=png,gif,jpeg \
		${myconf} || die

	emake MOZ_THUNDERBIRD=1 || die

	# Build the enigmail plugin
	if use crypt; then
		einfo "Building Enigmail plugin..."
		cd ${S}/extensions/ipc || die "cd ipc failed"
		make || die "make ipc failed"

		cd ${S}/extensions/enigmail || die "cd enigmail failed"
		make || die "make enigmail failed"
	fi
}

src_install() {
	dodir /usr/lib
	dodir /usr/lib/MozillaThunderbird
	cp -RL --no-preserve=links ${S}/dist/bin/* ${D}/usr/lib/MozillaThunderbird

	# fix permissions
	chown -R root:root ${D}/usr/lib/MozillaThunderbird

	# use mozilla-launcher which supports thunderbird as of version 1.6.
	# version 1.7-r1 moved the script to /usr/libexec
	dodir /usr/bin
	dosym /usr/libexec/mozilla-launcher /usr/bin/thunderbird

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/thunderbird-icon.png
	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillathunderbird.desktop

	# Normally thunderbird-0.7.1 must be run as root once before it can
	# be run as a normal user.  Drop in some initialized files to
	# avoid this.
	einfo "Extracting thunderbird-${PV} initialization files"
	tar xjpf ${FILESDIR}/thunderbird-0.7-init.tar.bz2 \
		-C ${D}/usr/lib/MozillaThunderbird
}

pkg_preinst() {
	# Remove entire installed instance to solve various
	# problems, for example see bug 27719
	rm -rf ${ROOT}/usr/lib/MozillaThunderbird
}

pkg_postinst() {
	export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/MozillaThunderbird"

	# Fix permissions on misc files
	find ${MOZILLA_FIVE_HOME}/ -perm 0700 -exec chmod 0755 {} \; || :

	# Needed to update the run time bindings for REGXPCOM
	# (do not remove next line!)
	env-update

	# Register Components and Chrome
	einfo "Registering Components and Chrome..."
	LD_LIBRARY_PATH=${ROOT}/usr/lib/MozillaThunderbird ${MOZILLA_FIVE_HOME}/regxpcom
	LD_LIBRARY_PATH=${ROOT}/usr/lib/MozillaThunderbird ${MOZILLA_FIVE_HOME}/regchrome

	# Fix permissions of component registry
	chmod 0644 ${MOZILLA_FIVE_HOME}/components/compreg.dat

	# Fix directory permissions
	find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 0755 {} \; || :

	# Fix permissions on chrome files
	find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \; || :

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks

	einfo
	einfo "Please note that the binary name has changed from MozillaThunderbird"
	einfo "to simply thunderbird"
	einfo
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
