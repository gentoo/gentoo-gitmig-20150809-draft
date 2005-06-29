# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-1.0.2-r10.ebuild,v 1.1 2005/06/29 13:34:37 agriffis Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils nsplugins mozconfig mozilla-launcher makeedit multilib

EMVER="0.92.0"
IPCVER="1.1.3"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}/source/thunderbird-${PV}-source.tar.bz2"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE=""

RDEPEND=">=www-client/mozilla-launcher-1.33"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1
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

	# patch out ft caching code since the API changed between releases of
	# freetype; this enables freetype-2.1.8+ compat.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=234035#c65
	epatch ${FILESDIR}/mozilla-thunderbird-0.9-4ft2.patch

	# GCC 4 compile patch ; bug #87800
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/thunderbird

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# tb-specific settings
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' \
		--with-default-mozilla-five-home=${MOZILLA_FIVE_HOME} \
		--with-user-appdir=.thunderbird

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, and this breaks
	# thunderbird
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

	emake || die "emake failed"
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/thunderbird

	# Most of the installation happens here
	dodir ${MOZILLA_FIVE_HOME}
	cp -RL --no-preserve=links ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME}

	# Chromes will live in /var, registered in pkg_postinst
	keepdir ${MOZILLA_FIVE_HOME/usr/var}

	# Create /usr/bin/thunderbird
	install_mozilla_launcher_stub thunderbird $MOZILLA_FIVE_HOME

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/thunderbird-icon.png

	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillathunderbird.desktop
}

pkg_preinst() {
	# Remove entire installed instance to solve various
	# problems, for example see bug 27719
	rm -rf ${ROOT}/usr/$(get_libdir)/thunderbird
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/thunderbird"

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=thunderbird \
		/usr/libexec/mozilla-launcher -register

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
