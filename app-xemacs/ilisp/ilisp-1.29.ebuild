# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ilisp/ilisp-1.29.ebuild,v 1.6 2004/08/10 02:15:24 tgall Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Front-end for Inferior Lisp."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/fsf-compat
app-xemacs/eterm
app-xemacs/sh-script
"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages

