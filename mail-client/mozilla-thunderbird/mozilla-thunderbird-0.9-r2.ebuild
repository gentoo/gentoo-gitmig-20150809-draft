# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-0.9-r2.ebuild,v 1.3 2004/11/16 16:08:54 agriffis Exp $

IUSE="crypt"

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic gcc eutils nsplugins mozconfig mozilla-launcher makeedit

EMVER="0.86.0"
IPCVER="1.0.8"

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

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd failed"

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${FILESDIR}/mozilla-alpha-xpcom-subs-fix.patch
		fi
	fi

	# Unpack the enigmail plugin
	if use crypt; then
		for x in ipc enigmail; do
			mv ${WORKDIR}/${x} ${S}/extensions || die "mv failed"
			cd ${S}/extensions/${x} || die "cd failed"
			makemake	# from mozilla.eclass
		done
	fi
}

src_compile() {
	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# tb-specific settings
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' --with-default-mozilla-five-home=/usr/lib/MozillaThunderbird

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, and this breaks
	# firefox.
	has_hardened && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

	####################################
	#
	#  Configure and build Thunderbird
	#
	####################################

	econf || die "econf failed"

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake MOZ_THUNDERBIRD=1 || die "emake failed"

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
	#
	# Bug 67031: Set HOME=~root in case this is being emerged via sudo.
	# Otherwise the following commands will create ~/.mozilla owned by root
	# and 700 perms, which makes subsequent execution of firefox by user
	# impossible.
	einfo "Registering Components and Chrome..."
	HOME=~root LD_LIBRARY_PATH=/usr/lib/MozillaThunderbird ${MOZILLA_FIVE_HOME}/regxpcom
	HOME=~root LD_LIBRARY_PATH=/usr/lib/MozillaThunderbird ${MOZILLA_FIVE_HOME}/regchrome

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
