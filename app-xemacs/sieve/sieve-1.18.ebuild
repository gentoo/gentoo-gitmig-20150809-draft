# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sieve/sieve-1.18.ebuild,v 1.1 2006/11/12 13:15:00 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Manage Sieve email filtering scripts."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/cc-mode
app-xemacs/sasl
app-xemacs/ecrypto
app-xemacs/sh-script
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

