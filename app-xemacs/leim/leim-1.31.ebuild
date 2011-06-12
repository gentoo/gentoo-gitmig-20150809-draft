# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/leim/leim-1.31.ebuild,v 1.2 2011/06/12 04:18:58 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Quail.  All non-English and non-Japanese language support."
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
app-xemacs/fsf-compat
app-xemacs/xemacs-base
app-xemacs/latin-euro-standards
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages
