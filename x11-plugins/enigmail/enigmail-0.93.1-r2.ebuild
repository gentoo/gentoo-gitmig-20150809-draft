# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/enigmail/enigmail-0.93.1-r2.ebuild,v 1.1 2006/01/12 08:05:30 anarchy Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils nsplugins mozcoreconf makeedit multilib autotools

EMVER=${PV}
TBVER="1.5"
IPCVER="1.1.3"

DESCRIPTION="Gnupg encryption plugin for thunderbird."
HOMEPAGE="http://www.enigmail.mozdev.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${TBVER}/source/thunderbird-${TBVER}-source.tar.bz2
	http://www.mozilla-enigmail.org/downloads/src/enigmail-${EMVER}.tar.gz
	http://downloads.mozdev.org/enigmail/src/ipc-${IPCVER}.tar.gz "

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE=""

DEPEND=">=mail-client/mozilla-thunderbird-1.5"
RDEPEND="${DEPEND}
	>=app-crypt/gnupg-1.4
	>=www-client/mozilla-launcher-1.37"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1
export MOZ_CO_PROJECT=mail

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd failed"

	epatch ${FILESDIR}/firefox-1.5-visibility-check.patch
	epatch ${FILESDIR}/firefox-1.5-visibility-fix.patch

	# Unpack the enigmail plugin
	for x in ipc enigmail; do
		mv ${WORKDIR}/${x} ${S}/extensions || die "mv failed"
		cd ${S}/extensions/${x} || die "cd failed"
		makemake	# from mozconfig.eclass
	done
	cd ${S}

	# Use the right theme for thunderbird #45609
	sed -i -ne '/^enigmail-skin.jar:$/ { :x; n; /^\t/bx; }; p' extensions/enigmail/ui/jar.mn

	# Don't allow upgrades via the browser
	epatch ${FILESDIR}/50_enigmail_no_upgrade.patch

	# Fix installation of enigmail.js
	epatch ${FILESDIR}/70_enigmail-fix.patch

	eautoreconf || die "failed running autoreconf"
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/mozilla-thunderbird

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# tb-specific settings
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

	econf  || die "econf failed"

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	# Only build the parts necessary to support building enigmail
	emake -j1 export || die "make export failed"
	emake -C modules/libreg || die "make modules/libreg failed"
	emake -C xpcom/string || die "make xpcom/string failed"
	emake -C xpcom || die "make xpcom failed"
	emake -C xpcom/obsolete || die "make xpcom/obsolete failed"

	# Build the enigmail plugin
	einfo "Building Enigmail plugin..."
	emake -C extensions/ipc || die "make ipc failed"
	emake -C extensions/enigmail || die "make enigmail failed"

	# Package the enigmail plugin; this may be the easiest way to collect the
	# necessary files
	emake -j1 -C extensions/enigmail xpi || die "make xpi failed"
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/mozilla-thunderbird
	declare emid

	cd ${T}
	unzip ${S}/dist/bin/*.xpi install.rdf
	emid=$(sed -n '/<em:id>/!d; s/.*\({.*}\).*/\1/; p; q' install.rdf)

	dodir ${MOZILLA_FIVE_HOME}/extensions/${emid}
	cd ${D}${MOZILLA_FIVE_HOME}/extensions/${emid}
	unzip ${S}/dist/bin/*.xpi

	# these files will be picked up by mozilla-launcher -register
	dodir ${MOZILLA_FIVE_HOME}/{chrome,extensions}.d
	insinto ${MOZILLA_FIVE_HOME}/chrome.d
	newins ${S}/dist/bin/chrome/installed-chrome.txt ${PN}
	echo "extension,${emid}" > ${D}${MOZILLA_FIVE_HOME}/extensions.d/${PN}
}
