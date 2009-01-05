# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/purple-plugin_pack/purple-plugin_pack-2.5.1.ebuild,v 1.3 2009/01/05 05:46:53 tester Exp $

inherit eutils

DESCRIPTION="A package with many different plugins for pidgin and libpurple"
HOMEPAGE="http://plugins.guifications.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="talkfilters debug gtk ncurses spell"

RDEPEND="net-im/pidgin
	talkfilters? ( app-text/talkfilters )
	spell? ( app-text/gtkspell )"
DEPEND="${RDEPEND}
	dev-lang/python"

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

	# XMMS Remote is disabled due to XMMS being masked
	DISABLED_PLUGINS="xmmsremote"

	use talkfilters || DISABLED_PLUGINS="${DISABLED_PLUGINS} talkfilters"
	use spell || DISABLED_PLGUINS="${DISABLED_PLUGINS} switchspell"

	plugins="$(python plugin_pack.py -p dist_dirs)"
	use gtk && plugins="${plugins} $(python plugin_pack.py -P dist_dirs)"
	use ncurses && plugins="${plugins} $(python plugin_pack.py -f dist_dirs)"

	# Disable incomplete plugins too
	DISABLED_PLUGINS="${DISABLED_PLUGINS} $(python plugin_pack.py -i dist_dirs)"

	for i in $DISABLED_PLUGINS; do
		plugins="${plugins//$i/}"
		plugins="${plugins//  / }"
		plugins="${plugins/# /}"
		plugins="${plugins/% /}"
		echo disabled $i
		echo $plugins
	done

	plugins="${plugins// /,}"

	econf --with-plugins="${plugins}" $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README VERSION
}
