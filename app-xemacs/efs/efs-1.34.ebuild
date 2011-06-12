# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/efs/efs-1.34.ebuild,v 1.2 2011/06/12 04:07:18 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Treat files on remote systems the same as local files."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/dired
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages
