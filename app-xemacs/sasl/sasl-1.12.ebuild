# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sasl/sasl-1.12.ebuild,v 1.5 2003/10/03 02:38:22 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Simple Authentication and Security Layer (SASL) library."
PKG_CAT="standard"

DEPEND="app-xemacs/ecrypto
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

