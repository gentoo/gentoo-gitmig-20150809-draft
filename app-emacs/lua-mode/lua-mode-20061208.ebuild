# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-20061208.ebuild,v 1.1 2006/12/19 06:28:04 opfer Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
SRC_URI="http://luaforge.net/frs/download.php/2074/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"

S="${WORKDIR}"

src_compile() {
	/usr/bin/emacs -batch --no-site-file --no-init-file \
		--load "${S}/lua-mode.el" -f batch-byte-compile lua-mode.el
}