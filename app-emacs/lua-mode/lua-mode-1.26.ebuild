# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-1.26.ebuild,v 1.2 2004/01/01 22:23:49 jbms Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"

SITEFILE="70${PN}-gentoo.el"

src_unpack() {
	elisp_src_unpack
	# Fix it so that it can be byte compiled.  Apparently, it
	# wasn't tested with the byte compiler.
	local sed_expr='s/eval-when-compile/progn/g'
	cp "${S}/lua-mode.el" "${T}"
	sed -e "${sed_expr}" "${T}/lua-mode.el" > "${S}/lua-mode.el"
}
