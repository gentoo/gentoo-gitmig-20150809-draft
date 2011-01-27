# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-live/vdr-live-0.2.0.20110118-r1.ebuild,v 1.1 2011/01/27 17:58:10 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin ssl-cert

DESCRIPTION="VDR Plugin: Web Access To Settings"
HOMEPAGE="http://live.vdr-developer.org"
#SRC_URI="http://live.vdr-developer.org/downloads/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz
		http://vdr.websitec.de/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND="media-video/vdr
	>=dev-libs/tntnet-2.0[ssl=,sdk]
	>=dev-libs/cxxtools-2.0"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${VDRPLUGIN}"

VDR_CONFD_FILE="${FILESDIR}/confd-0.2"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-0.2.sh"

make_live_cert() {
	# ssl-cert eclass create invalide cert, create my own

	SSL_ORGANIZATION="${SSL_ORGANIZATION:-VDR Plugin Live}"
	SSL_COMMONNAME="${SSL_COMMONNAME:-`hostname -f`}"

	echo
	gen_cnf || return 1
	echo
	gen_key 1 || return 1
	gen_csr 1 || return 1
	gen_crt 1 || return 1
	echo
}

src_prepare() {
	vdr-plugin_src_prepare

	#make it work with /bin/sh as indicated in the file header
	sed -e "18s/==/=/" -i  buildutil/version-util

	sed -e "s/ERROR:/WARNING:/" -i tntconfig.cpp

	if ! has_version ">=media-video/vdr-1.7.13"; then
	sed -i "s:-include \$(VDRDIR)/Make.global:#-include \$(VDRDIR)/Make.global:" Makefile
	fi
}

src_install() {
	vdr-plugin_src_install

	cd "${S}/live"
	insinto /etc/vdr/plugins/live
	doins -r *

	chown vdr:vdr -R "${D}"/etc/vdr/plugins/live
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "To be able to use all functions of vdr-live"
	elog "you should emerge and enable vdr-epgsearch"
	elog
	elog "\temerge >=vdr-epgsearch-0.9.25_beta7"
	elog "\teselect vdr-plugin enable epgsearch"
	echo
	ewarn "This is a developer snapshot"
	einfo "On problems, use the stable amd64, x86 versions of"
	einfo "dev-libs/tntnet dev-libs/cxxtools media-plugins/vdr-live"

	# Do not install live.{key,crt) SSL certificates if they already exist
	if use ssl && [[ ! -f "${ROOT}"/etc/vdr/plugins/live/live.key \
		&& ! -f "${ROOT}"/etc/vdr/plugins/live/live.crt ]] ; then
			make_live_cert
			local base=$(get_base 1)
			local keydir="/etc/vdr/plugins/live"
			install -d "${ROOT}${keydir}"
			install -m0400 "${base}.key" "${ROOT}${keydir}/live.key"
			install -m0444 "${base}.crt" "${ROOT}${keydir}/live.crt"
			chown vdr:vdr "${ROOT}"/etc/vdr/plugins/live/live.*
	fi
}
