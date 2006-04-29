# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/enigmail/enigmail-0.94.0-r2.ebuild,v 1.3 2006/04/29 02:53:17 anarchy Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils nsplugins mozcoreconf makeedit multilib autotools

EMVER=${PV}
TBVER="1.5.0.2"
TBPVER="1.2"

DESCRIPTION="Gnupg encryption plugin for thunderbird."
HOMEPAGE="http://www.enigmail.mozdev.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${TBVER}/source/thunderbird-${TBVER}-source.tar.bz2
	mirror://gentoo/mozilla-thunderbird-${TBVER}-patches-${TBPVER}.tar.bz2
	http://dev.gentoo.org/~anarchy/dist/mozilla-thunderbird-${TBVER}-patches-${TBPVER}.tar.bz2
	http://www.mozilla-enigmail.org/downloads/src/enigmail-${EMVER}.tar.gz"

KEYWORDS="~amd64 ~ia64 ppc ~x86"
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
	unpack thunderbird-${TBVER}-source.tar.bz2 mozilla-thunderbird-${TBVER}-patches-${TBPVER}.tar.bz2 || die "unpack failed"
	cd ${S} || die "cd failed"

	# Apply our patches
	EPATCH_FORCE="yes" epatch ${WORKDIR}/patch

	# Unpack the enigmail plugin
	cd ${S}/mailnews/extensions || die
	unpack enigmail-${EMVER}.tar.gz
	cd ${S}/mailnews/extensions/enigmail || die "cd failed"
	typeset m topdir
	for m in $(find ../ -name Makefile.in); do
		topdir=$(echo "$m" | sed -r 's:[^/]+:..:g')
		sed -e "s:@srcdir@:.:g" -e "s:@top_srcdir@:${topdir}:g" \
			< ${m} > ${m%.in} || die "sed ${m} failed"
	done

	cd ${S}

	# Use the right theme for thunderbird #45609
	sed -i -ne '/^enigmail-skin.jar:$/ { :x; n; /^\t/bx; }; p' mailnews/extensions/enigmail/ui/jar.mn

	# Don't allow upgrades via the browser
	epatch ${FILESDIR}/50_enigmail_no_upgrade-1.patch

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
		--with-system-nspr \
		--with-system-nss \
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
	emake -C ${S}/mailnews/extensions/enigmail || die "make enigmail failed"

	# Package the enigmail plugin; this may be the easiest way to collect the
	# necessary files
	emake -j1 -C ${S}/mailnews/extensions/enigmail xpi || die "make xpi failed"
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
