# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/net-utils/net-utils-1.56.ebuild,v 1.2 2011/06/12 04:24:56 tomka Exp $

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
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages
