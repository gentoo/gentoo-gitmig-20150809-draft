# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mail-lib/mail-lib-1.56.ebuild,v 1.10 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Fundamental lisp files for providing email support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-eterm
app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/sh-script
app-xemacs/ecrypto
"
KEYWORDS="amd64 x86 ppc alpha sparc ppc64"

inherit xemacs-packages
