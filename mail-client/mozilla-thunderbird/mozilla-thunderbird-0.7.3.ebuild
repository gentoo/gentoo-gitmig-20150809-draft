# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-0.7.3.ebuild,v 1.1 2004/08/04 23:49:53 agriffis Exp $

IUSE="crypt gtk2"

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic gcc eutils nsplugins mozilla mozilla-launcher

EMVER="0.85.0"
IPCVER="1.0.7"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}/thunderbird-${PV}-source.tar.bz2
	 crypt? ( http://downloads.mozdev.org/enigmail/src/enigmail-${EMVER}.tar.gz
	   		  http://downloads.mozdev.org/enigmail/src/ipc-${IPCVER}.tar.gz )"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

RDEPEND="crypt? ( >=app-crypt/gnupg-1.2.1 )"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_THUNDERBIRD=1
export MOZ_ENABLE_XFT=1

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die

	# Unpack the enigmail plugin
	if use crypt; then
		for x in ipc enigmail; do
			mv ${WORKDIR}/${x} ${S}/extensions || die
			cd ${S}/extensions/${x} || die
			makemake	# from mozilla.eclass
		done
	fi
}

src_compile() {
	local myconf

	####################################
	#
	# myconf, CFLAGS and CXXFLAGS setup
	#
	####################################

	# mozilla_conf comes from mozilla.eclass
	# It sets up CFLAGS, CXXFLAGS and myconf
	mozilla_conf

	myconf="${myconf} \
		--with-default-mozilla-five-home=/usr/lib/MozillaThunderbird \
		--enable-extensions=wallet,spellcheck"

	####################################
	#
	#  Configure and build Thunderbird
	#
	####################################

	econf ${myconf} || die

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
