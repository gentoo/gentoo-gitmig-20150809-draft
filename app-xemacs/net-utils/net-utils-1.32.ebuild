# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/net-utils/net-utils-1.32.ebuild,v 1.2 2004/02/21 22:45:51 brad_mssw Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous Networking Utilities."
PKG_CAT="standard"

DEPEND="app-xemacs/bbdb
app-xemacs/w3
app-xemacs/efs
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/eterm
app-xemacs/sh-script
app-xemacs/gnus
app-xemacs/rmail
app-xemacs/tm
app-xemacs/apel
"
KEYWORDS="amd64 x86 ~ppc alpha sparc"

inherit xemacs-packages

