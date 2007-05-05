# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/bbdb/bbdb-1.21.ebuild,v 1.12 2007/05/05 15:21:48 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="The Big Brother Data Base"
PKG_CAT="standard"

RDEPEND="app-xemacs/edit-utils
app-xemacs/gnus
app-xemacs/mh-e
app-xemacs/rmail
app-xemacs/supercite
app-xemacs/vm
app-xemacs/tm
app-xemacs/apel
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/w3
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
