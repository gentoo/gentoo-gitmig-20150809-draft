# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edict/edict-1.16.ebuild,v 1.2 2007/05/29 18:26:59 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Lisp Interface to EDICT, Kanji Dictionary"
PKG_CAT="mule"

RDEPEND="app-xemacs/mule-base
app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages
