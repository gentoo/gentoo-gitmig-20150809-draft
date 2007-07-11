# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sieve/sieve-1.11.ebuild,v 1.7 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Manage Sieve email filtering scripts."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/cc-mode
app-xemacs/sasl
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
