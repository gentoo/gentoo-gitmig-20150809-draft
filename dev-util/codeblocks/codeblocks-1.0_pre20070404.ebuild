# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/codeblocks/codeblocks-1.0_pre20070404.ebuild,v 1.1 2007/04/04 21:11:48 jurek Exp $

#
# WARNING:
#	If you are using gtk2.8 you need to upgrade to wxGTK-2.6.2
#

inherit eutils autotools wxwidgets

#needed for wxwidgets.eclass
WX_GTK_VER="2.6"

DESCRIPTION="Code::Blocks - a free cross-platform C/C++ IDE"
HOMEPAGE="http://www.codeblocks.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="unicode contrib debug"

RDEPEND="=x11-libs/wxGTK-${WX_GTK_VER}*"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.5
	>=sys-devel/automake-1.7
	>=sys-devel/libtool-1.4"

pkg_setup() {
	if use unicode; then
		#check for gtk2-unicode
		need-wxwidgets unicode
	else
		#check for gtk2-ansi
		need-wxwidgets gtk2
	fi
}

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

	local TMP

	TMP="/usr/share/aclocal/libtool.m4"
	einfo "Running ./bootstrap"
	if [ -e "$TMP" ]; then
		cp "$TMP" aclocal.m4 || die "cp failed"
	fi
	./bootstrap || die "boostrap failed"

	econf --with-wx-config="${WX_CONFIG}" \
		$(use_enable contrib) \
		$(use_enable debug) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}
