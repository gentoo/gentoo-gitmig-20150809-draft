# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/calendar/calendar-1.4a.ebuild,v 1.1 2006/09/08 18:19:45 pioto Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: calendar window"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=52"
LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a calendar window for vim. To start it, use the
:Calendar command."

# bug #62677
RDEPEND="!app-vim/cvscommand"
