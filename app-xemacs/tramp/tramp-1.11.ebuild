# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/tramp/tramp-1.11.ebuild,v 1.4 2004/04/01 02:02:58 jhuebel Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Remote shell-based file editing."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/vc
app-xemacs/fsf-compat
app-xemacs/efs
app-xemacs/dired
app-xemacs/mail-lib
app-xemacs/gnus
app-xemacs/ediff
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

