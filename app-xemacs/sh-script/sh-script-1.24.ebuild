# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sh-script/sh-script-1.24.ebuild,v 1.3 2011/06/25 18:51:32 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for editing shell scripts."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 sparc x86"

inherit xemacs-packages
