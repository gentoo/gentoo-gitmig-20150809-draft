# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/prog-modes/prog-modes-2.09.ebuild,v 1.1 2006/12/22 09:40:28 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for various programming languages."
PKG_CAT="standard"

RDEPEND="app-xemacs/mail-lib
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
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

