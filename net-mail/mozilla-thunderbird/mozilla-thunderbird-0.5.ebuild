# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mozilla-thunderbird/mozilla-thunderbird-0.5.ebuild,v 1.5 2004/03/25 08:32:45 mr_bones_ Exp $

inherit makeedit flag-o-matic gcc nsplugins

# Added to get thunderbird to compile on sparc.
replace-sparc64-flags
if [ "`use ppc`" -a "$(gcc-major-version)" -eq "3" -a "$(gcc-minor-version)" -eq "3" ]
then

append-flags -fno-strict-aliasing

fi


S=${WORKDIR}/mozilla

EMVER="0.83.2"
IPCVER="1.0.5"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird/"
SRC_URI="mirror://gentoo/thunderbird-${PV}-source.tar.bz2
	 crypt? ( mirror://gentoo/enigmail-${EMVER}.tar.gz
	   		  http://downloads.mozdev.org/enigmail/src/ipc-${IPCVER}.tar.gz )"

KEYWORDS="x86 ~ppc sparc ~alpha ~amd64"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"
IUSE="gtk2 ipv6 crypt"

RDEPEND="virtual/x11
	>=dev-libs/libIDL-0.8.0
	>=gnome-base/ORBit-0.5.10-r1
	virtual/xft
	>=sys-libs/zlib-1.1.4
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.36
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	gtk2? ( >=x11-libs/gtk+-2.1.1 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	crypt? ( >=app-crypt/gnupg-1.2.1 )"

DEPEND="${RDEPEND}
	virtual/glibc
	dev-util/pkgconfig
	dev-lang/perl"

# needed by src_compile() and src_install()
export MOZ_THUNDERBIRD=1
export MOZ_ENABLE_XFT=1

#pkg_setup() {
#	einfo "Please unmerge previous installs of Mozilla Thunderbird before"
#	einfo "merging this. Running emerge unmerge mozilla-thunderbird && rm -rf"
#	einfo "/usr/lib/MozillaThunderbird will ensure that all files are"
#	einfo "removed. If you need to do this, please press ctrl-c now and"
#	einfo "resume emerging once you're done."
#	sleep 5
#}

src_unpack() {

	unpack thunderbird-${PV}-source.tar.bz2

	# Unpack the enigmail plugin
	if use crypt
		then
			unpack ipc-${IPCVER}.tar.gz
			unpack enigmail-${EMVER}.tar.gz

			mv -f ${WORKDIR}/ipc ${S}/extensions/
			mv -f ${WORKDIR}/enigmail ${S}/extensions/
			cp ${FILESDIR}/enigmail/Makefile-ipc ${S}/extensions/ipc/Makefile
			cp ${FILESDIR}/enigmail/Makefile-enigmail ${S}/extensions/enigmail/Makefile
	fi

	use amd64 && epatch ${FILESDIR}/mozilla-thunderbird-amd64.patch
}

src_compile() {
	local myconf="--with-x \
		--with-system-jpeg \
		--with-system-zlib \
		--with-system-png \
		--with-system-mng \
		--disable-calendar \
		--enable-xft \
		--disable-pedantic \
		--disable-svg \
		--enable-mathml \
		--without-system-nspr \
		--enable-nspr-autoconf \
		--enable-xsl \
		--enable-crypto \
		--enable-xinerama=no \
		--with-pthreads \
		--with-default-mozilla-five-home=/usr/lib/MozillaThunderbird \
		--with-user-appdir=.thunderbird \
		--disable-jsd \
		--disable-accessibility \
		--disable-profilesharing \
		--disable-necko-disk-cache \
		--disable-activex-scripting \
		--disable-installer \
		--disable-activex \
		--disable-tests \
		--disable-debug \
		--disable-dtd-debug \
		--disable-logging \
		--enable-reorder \
		--enable-optimize="-O2" \
		--enable-strip \
		--enable-strip-libs \
		--enable-cpp-rtti \
		--enable-xterm-updates \
		--disable-toolkit-qt \
		--disable-toolkit-xlib \
		--enable-extensions=wallet,spellcheck \
		--enable-necko-protocols=http,file,jar,viewsource,res,data \
		--enable-image-decoders=png,gif,jpeg"

	if [ -n "`use gtk2`" ] ; then
		myconf="${myconf} --enable-toolkit-gtk2 \
							--enable-default-toolkit=gtk2 \
							--disable-toolkit-gtk"
	else
		myconf="${myconf} --enable-toolkit-gtk \
							--enable-default-toolkit=gtk \
							--disable-toolkit-gtk2"
	fi

	if [ -n "`use ipv6`" ] ; then
		myconf="${myconf} --enable-ipv6"
	fi

	# Crashes on start when compiled with -fomit-frame-pointer
	filter-flags -fomit-frame-pointer -mpowerpc-gfxopt
	filter-flags -ffast-math
	append-flags -s -fforce-addr

	if [ "$(gcc-major-version)" -eq "3" ]; then
		# Currently gcc-3.2 or older do not work well if we specify "-march"
		# and other optimizations for pentium4.
		if [ "$(gcc-minor-version)" -lt "3" ]; then
			replace-flags -march=pentium4 -march=pentium3
			filter-flags -msse2
		fi

	fi

	econf ${myconf} || die

	edit_makefiles
	emake MOZ_THUNDERBIRD=1 || die

	# Build the enigmail plugin
	if use crypt
	then
		einfo "Building Enigmail plugin..."
		cd ${S}/extensions/ipc
		make || die

		cd ${S}/extensions/enigmail
		make || die
	fi
}

src_install() {
	dodir /usr/lib
	dodir /usr/lib/MozillaThunderbird
	cp -RL --no-preserve=links ${S}/dist/bin/* ${D}/usr/lib/MozillaThunderbird

	#fix permissions
	chown -R root:root ${D}/usr/lib/MozillaThunderbird

	dobin ${FILESDIR}/thunderbird

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png

		# Fix comment of menu entry
		cd ${S}/build/package/rpm/SOURCES
		cp mozilla.desktop mozillathunderbird.desktop
		perl -pi -e 's:Name=Mozilla:Name=Mozilla Thunderbird:' mozillathunderbird.desktop
		perl -pi -e 's:Comment=Mozilla:Comment=Mozilla Thunderbird Mail Client:' mozillathunderbird.desktop
		perl -pi -e 's:Exec=/usr/bin/mozilla:Exec=/usr/bin/thunderbird:' mozillathunderbird.desktop
		cd ${S}
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozillathunderbird.desktop
	fi
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

	einfo "Please note that the binary name has changed from MozillaThunderbird"
	einfo "to simply 'thunderbird'."
}
