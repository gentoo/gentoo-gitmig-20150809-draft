# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sasl/sasl-1.12.ebuild,v 1.3 2003/02/13 09:57:30 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Simple Authentication and Security Layer (SASL) library."
PKG_CAT="standard"

DEPEND="app-xemacs/ecrypto
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

