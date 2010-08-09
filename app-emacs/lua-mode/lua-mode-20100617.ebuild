# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-20100617.ebuild,v 1.1 2010/08/09 06:31:13 fauli Exp $

EAPI=3

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
SRC_URI="http://luaforge.net/frs/download.php/4628/${PN}.el -> ${P}.el"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	mv "${DISTDIR}"/${P}.el "${WORKDIR}"/${PN}.el
}
