# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/net-utils/net-utils-1.52.ebuild,v 1.6 2008/05/05 13:27:48 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous Networking Utilities."
PKG_CAT="standard"

RDEPEND="app-xemacs/mail-lib
app-xemacs/gnus
app-xemacs/bbdb
app-xemacs/xemacs-base
app-xemacs/efs
"
KEYWORDS="alpha amd64 ppc ~ppc64 sparc x86"

inherit xemacs-packages
