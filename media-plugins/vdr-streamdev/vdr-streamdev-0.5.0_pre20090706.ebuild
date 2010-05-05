# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-streamdev/vdr-streamdev-0.5.0_pre20090706.ebuild,v 1.2 2010/05/05 15:17:49 hd_brummy Exp $

EAPI="1"

MY_P=${PN}-${PV/_pre/-pre-}
inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder Client/Server streaming plugin"
HOMEPAGE="http://streamdev.vdr-developer.org/"
SRC_URI="http://streamdev.vdr-developer.org/snapshots/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+client +server"

DEPEND=">=media-video/vdr-1.6.0
	!media-plugins/vdr-streamdev-client
	!media-plugins/vdr-streamdev-server"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P#vdr-}"

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! use client && ! use server; then
		die "no plugins selected, change useflags and enable at least client or server!"
	fi
}

src_unpack() {
	vdr-plugin_src_unpack
	cd "${S}"

	epatch "${FILESDIR}/vdr-streamdev-0.5.0-externremux-path.diff"

	# make subdir libdvbmpeg respect CXXFLAGS
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
		doins streamdev/streamdevhosts.conf
		chown vdr:vdr "${D}"/etc/vdr -R

		dodoc streamdev/externremux.sh
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst
	elog "If you want to use the externremux-feature, then put"
	elog "your custom script as /usr/share/vdr/streamdev/externremux.sh"

	if [[ -e "${ROOT}"/etc/vdr/plugins/streamdevhosts.conf ]]; then
		einfo "move config file to new config DIR ${ROOT}/etc/vdr/plugins/streamdev/"
		mv "${ROOT}"/etc/vdr/plugins/streamdevhosts.conf "${ROOT}"/etc/vdr/plugins/streamdev/streamdevhosts.conf
	fi
}
