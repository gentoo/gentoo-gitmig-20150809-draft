# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/strokes/strokes-1.10.ebuild,v 1.2 2007/05/29 21:49:55 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Mouse enhancement utility."
PKG_CAT="standard"

RDEPEND="app-xemacs/text-modes
app-xemacs/edit-utils
app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

