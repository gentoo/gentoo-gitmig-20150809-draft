# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ess/ess-1.03.ebuild,v 1.4 2004/04/01 00:21:55 jhuebel Exp $

SLOT="0"
IUSE=""
DESCRIPTION="ESS: Emacs Speaks Statistics."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/fsf-compat
app-xemacs/edit-utils
app-xemacs/speedbar
app-xemacs/sh-script
app-xemacs/eterm
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
