# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mh-e/mh-e-1.17.ebuild,v 1.6 2004/08/10 02:46:15 tgall Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Front end support for MH."
PKG_CAT="standard"

DEPEND="app-xemacs/gnus
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/speedbar
app-xemacs/rmail
app-xemacs/tm
app-xemacs/apel
app-xemacs/sh-script
app-xemacs/fsf-compat
"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages

