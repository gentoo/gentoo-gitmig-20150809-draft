# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-1.26-r1.ebuild,v 1.1 2003/12/29 00:44:20 jbms Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"

src_compile() {
	/usr/bin/emacs -batch --no-site-file --no-init-file \
		--load "${S}/lua-mode.el" -f batch-byte-compile lua-mode.el
}
