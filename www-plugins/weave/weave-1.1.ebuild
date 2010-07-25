# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/weave/weave-1.1.ebuild,v 1.3 2010/07/25 19:10:58 nirbheek Exp $

EAPI="2"

inherit eutils mozextension multilib

DESCRIPTION="Synchronize your bookmarks, history, tabs and passwords with Firefox"
HOMEPAGE="http://mozillalabs.com/weave/"
SRC_URI="http://hg.mozilla.org/labs/${PN}/archive/${PV}.tar.bz2
	-> ${P}.tar.bz2"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| (
		>=www-client/firefox-3.5
		>=www-client/firefox-bin-3.5
		>=www-client/seamonkey-2.0_alpha3
		>=www-client/seamonkey-bin-2.0_alpha3
	)
	>=net-libs/xulrunner-1.9.1
	>=dev-libs/nss-3.12
	>=dev-libs/nspr-4.7.1"
DEPEND="${RDEPEND}"

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
	if has_version '>=net-libs/xulrunner-1.9.2'; then
		epatch "${FILESDIR}"/${P}-pkgconfig.patch
	else
		epatch "${FILESDIR}"/${PN}-0.5.1-pkgconfig.patch
	fi
}

src_compile() {
	export WEAVE_BUILDID=${PV}

	emake -j1 rebuild_crypto=1 build || die "emake failed"
}

#src_test() {
#	emake -j1 test || die "emake test"
#}

src_install() {
	local MOZILLA_FIVE_HOME xpiname

	emake release_build=1 xpi || die "emake xpi failed"

	mozillas=""
	xpiname="${P}-rel"
	xpi_unpack "${S}/dist/xpi/${xpiname}.xpi"

	# FIXME: Hard-coded MOZILLA_FIVE_HOME dirs
	if has_version '>=www-client/firefox-3.5'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version www-client/firefox) ${mozillas}"
	fi
	if has_version '>=www-client/firefox-bin-3.5'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${WORKDIR}/${xpiname}"
		mozillas="$(best_version www-client/firefox-bin) ${mozillas}"
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
}

pkg_postinst() {
	elog "Weave has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "	$i"
	done
	elog
	elog "After installing other mozilla ebuilds, if you want to use weave with them,"
	elog "reinstall www-plugins/weave"

	echo ""
	elog "If weave from https://addons.mozilla.org/en-US/firefox/addon/10868 is working"
	elog "please, use it instead of that ebuild."
}
