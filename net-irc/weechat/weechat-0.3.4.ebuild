# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.3.4.ebuild,v 1.3 2011/02/09 04:56:50 darkside Exp $

EAPI=3

PYTHON_DEPEND="python? 2"

EGIT_REPO_URI="git://git.sv.gnu.org/weechat.git"
[[ ${PV} == "9999" ]] && GIT_ECLASS="git"
inherit python multilib cmake-utils ${GIT_ECLASS}

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.org/"
[[ ${PV} == "9999" ]] || SRC_URI="http://${PN}.org/files/src/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} == "9999" ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-linux ~amd64-linux"
fi

NETWORKS="+irc"
PLUGINS="+alias +charset +fifo +logger +relay +rmodifier +scripts +spell +xfer"
INTERFACES="+ncurses gtk"
SCRIPT_LANGS="lua +perl +python ruby tcl"
IUSE="${SCRIPT_LANGS} ${PLUGINS} ${INTERFACES} ${NETWORKS} +crypt doc nls +ssl"

RDEPEND="
	charset? ( virtual/libiconv )
	gtk? ( x11-libs/gtk+:2 )
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

DOCS="AUTHORS ChangeLog NEWS README"

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
