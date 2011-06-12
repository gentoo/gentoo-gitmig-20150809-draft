# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edict/edict-1.17.ebuild,v 1.2 2011/06/12 04:04:06 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Lisp Interface to EDICT, Kanji Dictionary"
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages
