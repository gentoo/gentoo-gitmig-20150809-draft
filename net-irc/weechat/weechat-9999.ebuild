# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-9999.ebuild,v 1.2 2010/12/13 22:35:41 idl0r Exp $

EAPI=2
inherit cmake-utils git

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.org/"
EGIT_REPO_URI="git://git.sv.gnu.org/weechat.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

NETWORKS="jabber +irc"
PLUGINS="+alias +charset +fifo +logger +relay +rmodifier +scripts +spell +xfer"
INTERFACES="+ncurses gtk"
SCRIPT_LANGS="lua +perl +python ruby tcl"
IUSE="${SCRIPT_LANGS} ${PLUGINS} ${INTERFACES} ${NETWORKS} +crypt doc nls +ssl"

RDEPEND="
	charset? ( virtual/libiconv )
	gtk? ( x11-libs/gtk+:2 )
	jabber? ( dev-libs/iksemel )
	lua? ( dev-lang/lua[deprecated] )
	ncurses? ( sys-libs/ncurses )
	perl? ( dev-lang/perl )
	python? ( virtual/python )
	ruby? ( dev-lang/ruby )
	ssl? ( net-libs/gnutls )
	spell? ( app-text/aspell )
	tcl? ( >=dev-lang/tcl-8.4.15 )
"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.15 )
"

DOCS="AUTHORS ChangeLog NEWS README "

# alias, rmodifier, xfer
src_configure() {
	mycmakeargs=(
		"-DENABLE_LARGEFILE=ON"
		"-DENABLE_DEMO=OFF"
		$(cmake-utils_use_enable ncurses)
		$(cmake-utils_use_enable gtk)
		$(cmake-utils_use_enable nls)
		$(cmake-utils_use_enable crypt GCRYPT)
		$(cmake-utils_use_enable spell ASPELL)
		$(cmake-utils_use_enable charset)
		$(cmake-utils_use_enable fifo)
		$(cmake-utils_use_enable irc)
		$(cmake-utils_use_enable logger)
		$(cmake-utils_use_enable relay)
		$(cmake-utils_use_enable scripts)
		$(cmake-utils_use_enable perl)
		$(cmake-utils_use_enable python)
		$(cmake-utils_use_enable ruby)
		$(cmake-utils_use_enable lua)
		$(cmake-utils_use_enable tcl)
		$(cmake-utils_use_enable doc)
	)

	cmake-utils_src_configure
}
