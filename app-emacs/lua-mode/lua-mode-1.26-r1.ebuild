# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-1.26-r1.ebuild,v 1.8 2005/04/24 11:01:38 hansmi Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE=""

SITEFILE="70${PN}-gentoo.el"

src_compile() {
	/usr/bin/emacs -batch --no-site-file --no-init-file \
		--load "${S}/lua-mode.el" -f batch-byte-compile lua-mode.el
}
