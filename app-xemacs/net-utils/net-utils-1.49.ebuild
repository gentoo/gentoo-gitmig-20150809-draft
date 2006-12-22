# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/net-utils/net-utils-1.49.ebuild,v 1.1 2006/12/22 09:32:36 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous Networking Utilities."
PKG_CAT="standard"

RDEPEND="app-xemacs/bbdb
app-xemacs/w3
app-xemacs/efs
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/xemacs-eterm
app-xemacs/sh-script
app-xemacs/gnus
app-xemacs/rmail
app-xemacs/tm
app-xemacs/apel
app-xemacs/vm
app-xemacs/mh-e
app-xemacs/mew
app-xemacs/ecrypto
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

