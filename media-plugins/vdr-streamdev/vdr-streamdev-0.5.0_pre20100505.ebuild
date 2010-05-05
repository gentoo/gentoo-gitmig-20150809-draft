# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-streamdev/vdr-streamdev-0.5.0_pre20100505.ebuild,v 1.1 2010/05/05 15:17:49 hd_brummy Exp $

EAPI="2"

MY_P="${PN}-${PV/_pre/-pre-}"
inherit vdr-plugin eutils

DESCRIPTION="vdr Plugin: Client/Server streaming plugin"
HOMEPAGE="http://streamdev.vdr-developer.org/"
SRC_URI="http://vdr.websitec.de/download/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+client +server"

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P#vdr-}"

EXTERNREMUX_PATH=/usr/share/vdr/streamdev/externremux.sh

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! use client && ! use server; then
		die "no plugins selected, change useflags and enable at least client or server!"
	fi
}

src_prepare() {
	vdr-plugin_src_prepare
	cd "${S}"

	# Moving externremux.sh out of /root
	sed -i remux/extern.c \
		-e "s#/root/externremux.sh#${EXTERNREMUX_PATH}#"

	# make subdir libdvbmpeg respect CXXFLAGS
	sed -i Makefile \
		-e '/CXXFLAGS.*+=/s:^:#:'
	sed -i libdvbmpeg/Makefile \
		-e 's:CFLAGS =  -g -Wall -O2:CFLAGS = $(CXXFLAGS) :'

	for flag in client server; do
		if ! use ${flag}; then
			sed -i Makefile \
				-e '/^all:/s/libvdr-$(PLUGIN)-'${flag}'.so//'
		fi
	done

	fix_vdr_libsi_include server/livestreamer.c
}

src_install() {
	vdr-plugin_src_install

	cd "${S}"
	if use server; then
		insinto /etc/vdr/plugins/streamdev
		newins streamdev/streamdevhosts.conf streamdevhosts.conf
		chown vdr:vdr "${D}"/etc/vdr -R
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "If you want to use the externremux-feature, then put"
	elog "your custom script as ${EXTERNREMUX_PATH}."

	if [[ -e "${ROOT}"/etc/vdr/plugins/streamdevhosts.conf ]]; then
		einfo "move config file to new config DIR ${ROOT}/etc/vdr/plugins/streamdev/"
		mv "${ROOT}"/etc/vdr/plugins/streamdevhosts.conf "${ROOT}"/etc/vdr/plugins/streamdev/streamdevhosts.conf
	fi
}
