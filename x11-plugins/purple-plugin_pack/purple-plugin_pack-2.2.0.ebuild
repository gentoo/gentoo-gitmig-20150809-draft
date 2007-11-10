# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/purple-plugin_pack/purple-plugin_pack-2.2.0.ebuild,v 1.1 2007/11/10 23:59:08 tester Exp $

inherit eutils

DESCRIPTION="A package with many different plugins for pidgin and libpurple"
HOMEPAGE="http://plugins.guifications.org"
SRC_URI="http://downloads.guifications.org/plugins/Plugin%20Pack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="talkfilters debug gtk ncurses"

DEPEND="net-im/pidgin
	talkfilters? ( app-text/talkfilters )"
RDEPEND="${DEPEND}"


pkg_setup() {
	if use gtk && ! built_with_use net-im/pidgin gtk; then
		eerror "You need to compile net-im/pidgin with USE=gtk to be"
		eerror "able to compile these plugins with gtk"
		die "Missing gtk USE flag on net-im/pidgin"
	fi

	if use ncurses && ! built_with_use net-im/pidgin ncurses; then
		eerror "You need to compile net-im/pidgin with USE=ncurses to be"
		eerror "able to compile these plugins with ncurses"
		die "Missing ncurses USE flag on net-im/pidgin"
	fi
}

src_compile() {
	local plugins=""

	# WARNING
	# This code to select plugins wont work with 2.2.0
	# because it ignores --with-plugins completely
	# and just always builds everything

	# XMMS Remote is disabled due to XMMS being masked
	DISABLED_PLUGINS="xmmsremote"

	use talkfilters || DISABLED_PLUGINS="${DISABLED_PLUGINS} talkfilters"

	for i in *; do
		[ -d ${i} ] || continue
		# We manually disable these plugins
		if [ -z "${DISABLED_PLUGINS##*${i}*}" ]; then
			continue
		fi

		# Only directories with .build files are meant to be built
		if [ ! -e ${i}/.build ]; then
			continue
		fi

		# Those should be generic#
		if [ -e ${i}/.purple-plugin ]; then
			plugins="${plugins},${i}"
		# These require gtk (ie pidgin)
		elif [ -e ${i}/.pidgin-plugin ]; then
			use gtk && plugins="${plugins},${i}"
		# These require ncurses (aka finch)
		elif [ -e ${i}/.finch-plugin ]; then
			use ncurses && plugins="${plugins},${i}"
		fi
	done



	econf --with-plugins="${plugins:1}" $(use_enable debug) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO VERSION
}
