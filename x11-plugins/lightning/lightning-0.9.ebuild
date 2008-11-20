# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/lightning/lightning-0.9.ebuild,v 1.1 2008/11/20 20:54:32 armin76 Exp $

WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils nsplugins mozcoreconf mozextension makeedit multilib autotools

SBPATCH="mozilla-sunbird-0.8-patches-0.1"

DESCRIPTION="Calendar extension for Mozilla Thunderbird."
HOMEPAGE="http://www.mozilla.org/projects/calendar/lightning/"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/source/${PN}-sunbird-${PV}-source.tar.bz2
	mirror://gentoo/${SBPATCH}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE=""
RESTRICT="test"

RDEPEND=">=mail-client/mozilla-thunderbird-2.0_alpha1
	>=www-client/mozilla-launcher-1.56"

S="${WORKDIR}/mozilla"

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1
export MOZ_CO_PROJECT=calendar

src_unpack() {
	unpack ${A%bz2*}bz2

	# Apply our patches
	cd "${S}" || die "cd failed"
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"/patch

	# Don't strip
	sed -i -e 's/STRIP_/#STRIP_/g' calendar/lightning/Makefile.in

	eautoreconf
}

src_compile() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-thunderbird"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	mozconfig_annotate '' --enable-application=calendar
	mozconfig_annotate '' --enable-extensions=lightning
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --with-system-nspr

	# Finalize and report settings
	mozconfig_final

	# -fstack-protector breaks us
	if gcc-version ge 4 1; then
		gcc-specs-ssp && append-flags -fno-stack-protector
	else
		gcc-specs-ssp && append-flags -fno-stack-protector-all
	fi
		filter-flags -fstack-protector -fstack-protector-all

	####################################
	#
	#  Configure and build Thunderbird
	#
	####################################

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	# Only build the parts necessary to support building enigmail
	emake -j1 export || die "make export failed"
	emake -C xpcom || die "make xpcom failed"
	emake -C js/ || die "make js failed"

	# Build the lightning plugin
	einfo "Building Lightning plugin..."
	emake -C "${S}"/calendar/lightning/ || die "make lightning failed"
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-thunderbird"
	declare emid

	cd "${T}"
	unzip "${S}"/dist/xpi-stage/${PN}.xpi install.rdf
	emid=$(sed -n -e '/<\?em:id>\?/!d; s/.*\([\"{].*[}\"]\).*/\1/; s/\"//g; p;' install.rdf | sed -e '1d') || die "failed to determine extension id"

	dodir ${MOZILLA_FIVE_HOME}/extensions/${emid}
	cd "${D}"${MOZILLA_FIVE_HOME}/extensions/${emid}
	unzip "${S}"/dist/xpi-stage/${PN}.xpi

	# these files will be picked up by mozilla-launcher -register
	dodir ${MOZILLA_FIVE_HOME}/{chrome,extensions}.d
	echo "extension,${emid}" > "${D}"${MOZILLA_FIVE_HOME}/extensions.d/${PN}
}
