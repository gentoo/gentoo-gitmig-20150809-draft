# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mail-lib/mail-lib-1.78.ebuild,v 1.1 2006/12/22 09:28:50 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Fundamental lisp files for providing email support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-eterm
app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/sh-script
app-xemacs/ecrypto
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

