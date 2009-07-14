# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/mozilla-weave/mozilla-weave-0.5_pre1.ebuild,v 1.1 2009/07/14 09:42:48 nirbheek Exp $

EAPI="2"

inherit mozextension multilib

MY_PN="weave"
MY_PV="${PV/_/}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Mozilla Labs prototype for online services into Firefox"
HOMEPAGE="http://labs.mozilla.com/projects/weave/"
SRC_URI="http://hg.mozilla.org/labs/${MY_PN}/archive/${MY_PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~x86"
KEYWORDS=""
IUSE=""

RDEPEND="|| (
		>=www-client/mozilla-firefox-3.5
		>=www-client/mozilla-firefox-bin-3.5
		>=www-client/seamonkey-bin-2.0_alpha3
		>=www-client/seamonkey-2.0_alpha3
		>=mail-client/mozilla-thunderbird-bin-3.0_beta2
		>=mail-client/mozilla-thunderbird-3.0_beta2
	)
	>=net-libs/xulrunner-1.9.1
	>=dev-libs/nss-3.12
	>=dev-libs/nspr-4.7.1"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

# XXX: fennec is also listed in install.rdf but not in-tree

src_prepare() {
	# Fix hard-coded paths in the Makefiles
	epatch "${FILESDIR}/${PN}-use-pkgconfig.patch"

	# remove compiled files
	rm -rf platform/*
}

src_compile() {
	if has_version '=net-libs/xulrunner-1.9.0*'; then
		export XULRUNNER_BIN="${ROOT}/usr/bin/xulrunner-1.9"
	elif has_version '=net-libs/xulrunner-1.9.1*'; then
		export XULRUNNER_BIN="${ROOT}/usr/bin/xulrunner-1.9.1"
	fi
	export WEAVE_BUILDID=${PV}

	emake release_build=1 xpi || die "emake failed"
}

src_install() {
	local MOZILLA_FIVE_HOME xpiname

	mozillas=""
	xpiname="${MY_P}-rel"
	xpi_unpack "${S}/${xpiname}.xpi"

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
	elog "To use Weave, you have to get an account at https://services.mozilla.com/"
	elog "Otherwise, you can setup your own server, see:"
	elog "https://wiki.mozilla.org/Labs/Weave/0.3/Setup/Server"
	elog
	elog "Weave has been installed for the following packages:"
	for i in ${mozillas}; do
		elog "	$i"
	done
	elog "After installing other mozilla ebuilds, if you want to use weave with them,"
	elog "reinstall www-plugins/mozilla-weave"
}
