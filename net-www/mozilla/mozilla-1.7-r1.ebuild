# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-1.7-r1.ebuild,v 1.2 2004/07/24 23:27:10 agriffis Exp $

IUSE="java crypt ipv6 gtk2 ssl ldap gnome debug xinerama xprint"
# Internal USE flags that I do not really want to advertise ...
IUSE="${IUSE} mozcalendar mozsvg"
IUSE="${IUSE} moznoirc moznomail moznocompose moznoxft"

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic gcc eutils nsplugins mozilla-launcher

EMVER="0.84.1"
IPCVER="1.0.6"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="The Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/${PN}${MY_PV}/src/${PN}-source-${MY_PV}.tar.bz2
	crypt? ( !moznomail? (
		http://downloads.mozdev.org/enigmail/src/ipc-${IPCVER}.tar.gz
		mirror://gentoo/enigmail-${EMVER}-r1.tar.gz
	) )"
# Normally the following would be used instead of the mirror://gentoo/
# reference above, but the upstream source tarball changed without
# changing the filename.  (17 Jun 2004 agriffis)
#		http://downloads.mozdev.org/enigmail/src/enigmail-${EMVER}.tar.gz

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

common_depends="virtual/x11
	>=sys-libs/zlib-1.1.4
	>=media-libs/fontconfig-2.1
	!moznoxft ( virtual/xft )
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.14
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
	java?  ( virtual/jre )
	crypt? ( !moznomail ( >=app-crypt/gnupg-1.2.1 ) )
	gnome? ( >=gnome-base/gnome-vfs-2.3.5 )"

DEPEND="${common_depends}
	dev-util/pkgconfig
	dev-lang/perl
	java? ( >=dev-java/java-config-0.2.0 )"

RDEPEND="${common_depends}
	>=net-www/mozilla-launcher-1.7-r1"

S="${WORKDIR}/mozilla"

pkg_setup() {
	# needed by src_compile() and src_install()
	export MOZILLA_OFFICIAL=1
	export BUILD_OFFICIAL=1

	# make sure the nss module gets build (for NSS support)
	if use ssl; then
		export MOZ_PSM="1"
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

src_unpack() {
	typeset x

	unpack ${A} || die "unpack failed"
	cd ${S} || die

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${FILESDIR}/${PN}-alpha-xpcom-subs-fix.patch
		fi
		# unecessary now, already in the source
		# Danny van Dyk <kugelfang@gentoo.org> 2004/06/20
		#if [[ ${ARCH} == amd64 ]]; then
		#	epatch ${FILESDIR}/${PN}-1.7-amd64.patch
		#fi
	fi

	epatch ${FILESDIR}/1.2/${PN}-1.2b-default-plugin-less-annoying.patch.bz2

	# Fix logic error when using RAW target
	# <azarah@gentoo.org> (23 Feb 2003)
	epatch ${FILESDIR}/1.3/${PN}-1.3-fix-RAW-target.patch

	# Fix incorrect version in milestone.txt (1.7rc1 claims 1.7b)
	# If 1.7rc2 is anything to go by, then milestone.txt should report
	# the upcoming version number, e.g. 1.7
	local old_milestone=$(grep '^[0-9]' config/milestone.txt)
	if [[ ${old_milestone} != ${PV%_*} ]]; then
		einfo "Updating milestone.txt from ${old_milestone} to ${PV%_*}"
		sed -i -ne '/^#/p' config/milestone.txt   # maintain comments
		echo "${PV%_*}" >> config/milestone.txt   # add version line
	fi

	WANT_AUTOCONF_2_1=1 autoconf &> /dev/null

	# Unpack the enigmail plugin
	if use crypt && ! use moznomail; then
		for x in ipc enigmail; do
			mv ${WORKDIR}/${x} ${S}/extensions || die
			cd ${S}/extensions/${x} || die
			makemake	# see function above
		done

		# Fix ipc-1.0.6 compilation problem by updating line from cvs
		# (09 Jun 2004 agriffis)
		cd ${S}/extensions/ipc
		epatch ${FILESDIR}/ipc-1.0.6-nsPipeChannel.patch
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

	if use moznomail && ! use mozcalendar; then
		myconf="${myconf} --disable-mailnews"
	fi
	if use moznocompose && use moznomail; then
		myconf="${myconf} --disable-composer"
	fi

	####################################
	#
	# myext setup
	#
	####################################

	# The defaults are:
	#     cookie wallet content-packs xml-rpc xmlextras help p3p pref
	#     transformiix venkman inspector irc universalchardet
	#     typeaheadfind webservices spellcheck
	# Non-defaults are:
	#     xmlterm access-builtin datetime finger cview

	# Remove access and xmlterm as options since they're preventing the build
	# more than they work. (04 Jul 2004 brad)
	#if use mozxmlterm || use mozaccess; then
	#	ewarn ""
	#	ewarn "NB!!: The use of the non-default extensions is considered"
	#	ewarn "unsupported, and these may not always compile properly."
	#	ewarn "Please do not use if you do not know what you're doing!"
	#	ewarn ""
	#	sleep 3
	#fi

	local myext="default"
	#use mozxmlterm && myext="${myext},xmlterm"
	#use mozaccess  && myext="${myext},access-builtin"
	use moznoirc   && myext="${myext},-irc"

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
	#  Configure and build Mozilla
	#
	####################################

	export BUILD_MODULES=all
	export BUILD_OPT=1

	cd ${S}
	einfo "Configuring Mozilla..."
	./configure --prefix=/usr/lib/mozilla \
		--with-system-jpeg \
		--with-system-mng \
		--with-system-png \
		--with-system-zlib \
		$(use_enable gnome gnomevfs) \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable mozcalendar calendar) \
		$(use_enable xprint) \
		$(use_enable xinerama) \
		--disable-pedantic \
		--disable-short-wchar \
		--enable-mathml \
		--without-system-nspr \
		--enable-nspr-autoconf \
		--enable-xsl \
		--enable-crypto \
		--enable-extensions="${myext}" \
		--enable-optimize="${enable_optimize}" \
		--with-default-mozilla-five-home=/usr/lib/mozilla \
		${myconf} || die

	einfo "Building Mozilla..."
	emake WORKDIR="${WORKDIR}" || die

	####################################
	#
	#  Build Mozilla NSS
	#
	####################################

	# Build the NSS/SSL support
	if use ssl; then
		einfo "Building Mozilla NSS..."

		# Fix #include problem
		cd ${S}/security/coreconf || die "cd coreconf failed"
		echo 'INCLUDES += -I$(DIST)/include/nspr -I$(DIST)/include/dbm'\
			>>headers.mk
		emake -j1 || die "make security headers failed"

		cd ${S}/security/nss || die "cd nss failed"
		emake -j1 moz_import || die "make moz_import failed"
		emake -j1 || die "make nss failed"
	fi

	####################################
	#
	#  Build Enigmail plugin
	#
	####################################

	# Build the enigmail plugin
	if use crypt && ! use moznomail; then
		einfo "Building Enigmail plugin..."
		cd ${S}/extensions/ipc || die "cd ipc failed"
		emake || die "make ipc failed"

		cd ${S}/extensions/enigmail || die "cd enigmail failed"
		emake || die "make enigmail failed"
	fi
}

src_install() {
	# Install, don't create tarball
	dodir /usr/lib
	cd ${S}/xpinstall/packager
	einfo "Installing mozilla into build root..."
	make MOZ_PKG_FORMAT="RAW" TAR_CREATE_FLAGS="-chf" > /dev/null || die
	mv -f ${S}/dist/mozilla ${D}/usr/lib/mozilla

	einfo "Installing includes and idl files..."
	# Copy the include and idl files
	dodir /usr/lib/mozilla/include/idl /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}/usr/lib/mozilla/include
	cp -LfR idl/* ${D}/usr/lib/mozilla/include/idl
	dosym /usr/lib/mozilla/include /usr/include/mozilla

	# Install the development tools in /usr
	dodir /usr/bin
	mv ${D}/usr/lib/mozilla/{xpcshell,xpidl,xpt_dump,xpt_link} ${D}/usr/bin

	# Install the NSS/SSL libs, headers and tools
	if use ssl; then
		einfo "Installing Mozilla NSS..."
		# Install the headers ('make install' do not work for headers ...)
		insinto /usr/lib/mozilla/include/nss
		[ -d ${S}/dist/public/nss ] && doins ${S}/dist/public/nss/*.h
		[ -d ${S}/dist/public/seccmd ] && doins ${S}/dist/public/seccmd/*.h
		[ -d ${S}/dist/public/security ] && doins ${S}/dist/public/security/*.h
		# These come with zlib ...
		rm -f ${D}/usr/lib/mozilla/include/nss/{zconf.h,zlib.h}

		cd ${S}/security/nss

		mkdir -p ${WORKDIR}/nss/{bin,lib}
		export BUILD_OPT=1
		export SOURCE_BIN_DIR=${WORKDIR}/nss/bin
		export SOURCE_LIB_DIR=${WORKDIR}/nss/lib

		make install || die
		# Gets installed as symbolic links ...
		cp -Lf ${WORKDIR}/nss/bin/* ${D}/usr/bin
		cp -Lf ${WORKDIR}/nss/lib/* ${D}/usr/lib/mozilla

		# Need to unset these incase we want to rebuild, else the build
		# gets newked.
		unset SOURCE_LIB_DIR
		unset SOURCE_BIN_DIR
	fi

	cd ${S}/build/unix
	# Fix mozilla-config and install it
	perl -pi -e "s:/lib/mozilla-${MY_PV}::g" mozilla-config
	perl -pi -e "s:/mozilla-${MY_PV}::g" mozilla-config
	exeinto /usr/lib/mozilla
	doexe mozilla-config
	# Fix pkgconfig files and install them
	insinto /usr/lib/pkgconfig
	for x in *.pc; do
		if [[ -f ${x} ]]; then
			perl -pi -e "s:/lib/mozilla-${MY_PV}::g" ${x}
			perl -pi -e "s:/mozilla-${MY_PV}::g" ${x}
			doins ${x}
		fi
	done
	cd ${S}

	dodir /usr/bin
	dosym /usr/libexec/mozilla-launcher /usr/bin/mozilla
	insinto /etc/env.d
	doins ${FILESDIR}/10mozilla
	dodoc LEGAL LICENSE README/mozilla/README*

	# Install rebuild script
	exeinto /usr/lib/mozilla/
	doexe ${FILESDIR}/mozilla-rebuild-databases.pl

	# Move plugins dir
	src_mv_plugins /usr/lib/mozilla/plugins

	# Update Google search plugin to use UTF8 charset ...
	insinto /usr/lib/mozilla/searchplugins
	doins ${FILESDIR}/google.src

	if [[ -f "${WORKDIR}/.xft" ]]; then
		# We are using Xft, so change the default font
		insinto /usr/lib/mozilla/defaults/pref
		doins ${FILESDIR}/xft.js
	fi

	# Fix icons to look the same everywhere
	insinto /usr/lib/mozilla/icons
	doins ${S}/widget/src/gtk/mozicon16.xpm
	doins ${S}/widget/src/gtk/mozicon50.xpm

	# Install icon and .desktop for menu entry
	if use gnome; then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/icon/mozilla-icon.png

		insinto /usr/share/applications
		doins ${FILESDIR}/icon/mozilla.desktop
	fi

	# Take care of non root execution
	# (seems the problem is that not all files are readible by the user)
	einfo "Fixing Permissions..."
	chmod -R g+r,o+r ${D}/usr/lib/mozilla
	find ${D}/usr/lib/mozilla/ -type d -exec chmod 0755 {} \; || :
}

pkg_preinst() {
	# Move old plugins dir
	pkg_mv_plugins /usr/lib/mozilla/plugins

	if true; then
		# Remove entire installed instance to solve various problems,
		# for example see bug 27719
		rm -rf ${ROOT}/usr/lib/mozilla
	else
		# Stale components and chrome files break when unmerging old
		rm -rf ${ROOT}/usr/lib/mozilla/components
		rm -rf ${ROOT}/usr/lib/mozilla/chrome

		# Remove stale component registry.
		rm -f ${ROOT}/usr/lib/mozilla/component.reg
		rm -f ${ROOT}/usr/lib/mozilla/components/compreg.dat

		# Make sure these are removed.
		rm -f ${ROOT}/usr/lib/mozilla/lib{Xft,Xrender}.so*
	fi
}

pkg_postinst() {
	export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"

	# Needed to update the run time bindings for REGXPCOM
	# (do not remove next line!)
	env-update

	# Register Components and Chrome
	einfo "Registering Components and Chrome..."
	${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl

	# Fix permissions of component registry
	chmod 0644 ${MOZILLA_FIVE_HOME}/components/compreg.dat

	# Fix directory permissions
	find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 0755 {} \;

	# Fix permissions on chrome files
	find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \;

	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	# Regenerate component.reg in case some things changed
	if [[ -e ${ROOT}/usr/lib/mozilla/regxpcom ]]; then
		export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"

		if [[ -x ${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl ]]; then
			${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl
			# Fix directory permissions
			find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \;
			# Fix permissions on chrome files
			find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \;
		fi
	fi

	update_mozilla_launcher_symlinks
}
