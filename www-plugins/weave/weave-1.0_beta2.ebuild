# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/weave/weave-1.0_beta2.ebuild,v 1.1 2009/11/25 20:35:36 volkmar Exp $

EAPI="2"

inherit eutils mozextension multilib

MY_PV="1.0b2"
MY_P=${PN}-${MY_PV}

DESCRIPTION="Mozilla Labs prototype for online services"
HOMEPAGE="http://labs.mozilla.com/projects/weave/"
SRC_URI="http://hg.mozilla.org/labs/${PN}/archive/${MY_PV}.tar.bz2
	-> ${P}.tar.bz2"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| (
		>=www-client/mozilla-firefox-3.5
		>=www-client/mozilla-firefox-bin-3.5
		>=www-client/seamonkey-2.0_alpha3
		>=www-client/seamonkey-bin-2.0_alpha3
		>=mail-client/mozilla-thunderbird-3.0_beta2
		>=mail-client/mozilla-thunderbird-bin-3.0_beta2
	)
	>=net-libs/xulrunner-1.9.1
	>=dev-libs/nss-3.12
	>=dev-libs/nspr-4.7.1"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

RESTRICT="test"

# NOTES:
# fennec is also listed in install.rdf but not in-tree

# TODO:
# tests are failing because they are not using pkgconfig
# parallel compilation isssues
# server ebuild: https://wiki.mozilla.org/Labs/Weave/0.5/Setup/Storage

src_prepare() {
	# remove compiled files
	rm -rf crypto/platform/* || die "rm -rf never dies"

	# upstream bug 504022
	epatch "${FILESDIR}"/${PN}-0.5.1-pkgconfig.patch
}

src_compile() {
	export WEAVE_BUILDID=${MY_PV}

	emake -j1 rebuild_crypto=1 build || die "emake failed"
}

#src_test() {
#	emake -j1 test || die "emake test"
#}

src_install() {
	local MOZILLA_FIVE_HOME xpiname

	emake release_build=1 xpi || die "emake xpi failed"

	mozillas=""
	xpiname="${MY_P}-rel"
	xpi_unpack "${S}/dist/xpi/${xpiname}.xpi"

	# FIXME: Hard-coded MOZILLA_FIVE_HOME dirs
	if has_version '>=www-client/mozilla-firefox-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version www-client/mozilla-firefox) ${mozillas}"
	fi
	if has_version '>=www-client/mozilla-firefox-bin-3.5'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version www-client/mozilla-firefox-bin) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-2.0_alpha3'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/seamonkey"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version www-client/seamonkey) ${mozillas}"
	fi
	if has_version '>=www-client/seamonkey-bin-2.0_alpha3'; then
		MOZILLA_FIVE_HOME="/opt/seamonkey"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version www-client/seamonkey-bin) ${mozillas}"
	fi
	if has_version '>=mail-client/mozilla-thunderbird-3.0_beta2'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-thunderbird"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version mail-client/mozilla-thunderbird) ${mozillas}"
	fi
	if has_version '>=mail-client/mozilla-thunderbird-bin-3.0_beta2'; then
		MOZILLA_FIVE_HOME="/opt/thunderbird"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version mail-client/mozilla-thunderbird-bin) ${mozillas}"
	fi
}

pkg_postinst() {
	elog "Weave has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "	$i"
	done
	elog
	elog "After installing other mozilla ebuilds, if you want to use weave with them,"
	elog "reinstall www-plugins/weave"

	# from to 1.0b2 (keep it a month or two)
	echo ""
	ewarn "You should update all your clients to at least 1.0_beta2."
}
