# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-20061208.ebuild,v 1.5 2007/10/09 15:29:58 pylon Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
SRC_URI="http://luaforge.net/frs/download.php/2074/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"

S="${WORKDIR}"
