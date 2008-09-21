# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/securemodelines/securemodelines-20080424.ebuild,v 1.1 2008/09/21 12:25:51 hawking Exp $

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: Secure, user-configurable modeline support."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1876"
LICENSE="vim"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

VIM_PLUGIN_HELPTEXT="Make sure that you disable vim's builtin modeline support if you have
enabled it in your .vimrc.

Documentation is available at:
http://ciaranm.org/tag/securemodelines"
