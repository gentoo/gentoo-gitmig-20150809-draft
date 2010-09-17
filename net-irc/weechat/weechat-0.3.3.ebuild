# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.3.3.ebuild,v 1.2 2010/09/17 10:35:44 scarabeus Exp $

EAPI=2

PYTHON_DEPEND="python? 2"

inherit python cmake-utils multilib

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.org/"
SRC_URI="http://${PN}.org/files/src/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"

NETWORKS="+irc"
PLUGINS="+charset +fifo +logger relay +scripts +spell"
INTERFACES="+ncurses"
SCRIPT_LANGS="lua +perl +python ruby tcl"
IUSE="${SCRIPT_LANGS} ${PLUGINS} ${INTERFACES} ${NETWORKS} doc nls +ssl"

RDEPEND="
	charset? ( virtual/libiconv )
	lua? ( dev-lang/lua[deprecated] )
	ncurses? ( sys-libs/ncurses )
	perl? ( dev-lang/perl )
	ruby? ( dev-lang/ruby )
	ssl? ( net-libs/gnutls )
	spell? ( app-text/aspell )
	tcl? ( >=dev-lang/tcl-8.4.15 )
"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.15 )
"

DOCS="AUTHORS ChangeLog NEWS README UPGRADE_0.3"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# fix libdir placement
	sed -i \
		-e "s:lib/:$(get_libdir)/:g" \
		-e "s:lib\":$(get_libdir)\":g" \
		CMakeLists.txt || die "sed failed"
}

src_configure() {
	local x

	for x in ${IUSE}; do
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_disable ${x/+/})"
	done

	cmake-utils_src_configure
}
