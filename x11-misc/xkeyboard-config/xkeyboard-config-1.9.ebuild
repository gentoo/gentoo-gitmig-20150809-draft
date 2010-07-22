# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeyboard-config/xkeyboard-config-1.9.ebuild,v 1.6 2010/07/22 16:25:44 maekke Exp $

EAPI=3

XORG_STATIC=no
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xkeyboard-config"

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/XKeyboardConfig"
SRC_URI="${BASE_INDIVIDUAL_URI}/data/xkeyboard-config/${P}.tar.bz2"

KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

LICENSE="MIT"
SLOT="0"

RDEPEND="x11-apps/xkbcomp"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	dev-perl/XML-Parser"

CONFIGURE_OPTIONS="
	--with-xkb-base=${EPREFIX}/usr/share/X11/xkb
	--enable-compat-rules
	--with-xkb-rules-symlink=xorg"

src_install() {
	xorg-2_src_install

	echo "CONFIG_PROTECT=\"${EPREFIX}/usr/share/X11/xkb\"" > "${T}"/10xkeyboard-config
	doenvd "${T}"/10xkeyboard-config
}
