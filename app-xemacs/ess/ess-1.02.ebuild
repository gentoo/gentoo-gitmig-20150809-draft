# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ess/ess-1.02.ebuild,v 1.6 2004/06/24 23:11:45 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="ESS: Emacs Speaks Statistics."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/fsf-compat
app-xemacs/edit-utils
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages
