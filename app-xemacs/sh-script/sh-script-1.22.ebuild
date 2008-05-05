# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sh-script/sh-script-1.22.ebuild,v 1.6 2008/05/05 13:29:03 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for editing shell scripts."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ~ppc64 sparc x86"

inherit xemacs-packages
