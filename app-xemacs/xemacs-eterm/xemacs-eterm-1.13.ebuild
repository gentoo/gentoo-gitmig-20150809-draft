# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-eterm/xemacs-eterm-1.13.ebuild,v 1.9 2005/01/01 17:20:56 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Terminal emulation."
PKG_CAT="standard"

MY_PN=${PN/xemacs-/}
SRC_URI="ftp://ftp.xemacs.org/packages/${MY_PN}-${PV}-pkg.tar.gz"

DEPEND="app-xemacs/xemacs-base"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages
