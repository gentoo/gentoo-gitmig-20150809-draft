# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/clearcase/clearcase-1.10.ebuild,v 1.2 2007/05/29 18:10:04 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="New Clearcase Version Control for XEmacs (UNIX, Windows)."
PKG_CAT="standard"

RDEPEND="app-xemacs/dired
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/sh-script
"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages
