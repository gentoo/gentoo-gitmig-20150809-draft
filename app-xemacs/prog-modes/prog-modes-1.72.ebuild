# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/prog-modes/prog-modes-1.72.ebuild,v 1.3 2004/02/21 22:45:51 brad_mssw Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for various programming languages."
PKG_CAT="standard"

DEPEND="app-xemacs/mail-lib
app-xemacs/xemacs-devel
app-xemacs/xemacs-base
app-xemacs/cc-mode
app-xemacs/fsf-compat
app-xemacs/edit-utils
app-xemacs/ediff
app-xemacs/emerge
app-xemacs/efs
app-xemacs/vc
app-xemacs/speedbar
app-xemacs/dired
app-xemacs/ilisp
app-xemacs/sh-script
"
KEYWORDS="amd64 x86 ~ppc alpha sparc"

inherit xemacs-packages

