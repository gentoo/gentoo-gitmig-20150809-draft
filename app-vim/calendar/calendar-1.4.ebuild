# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/calendar/calendar-1.4.ebuild,v 1.7 2005/02/22 22:59:40 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: calendar window"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=52"
LICENSE="vim"
KEYWORDS="x86 alpha ia64 sparc ~ppc amd64 ~mips"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a calendar window for vim. To start it, use the
:Calendar command."

# bug #62677
RDEPEND="!app-vim/cvscommand"
