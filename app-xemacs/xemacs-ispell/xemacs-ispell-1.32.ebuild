# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-ispell/xemacs-ispell-1.32.ebuild,v 1.1 2006/11/12 15:02:12 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Spell-checking with GNU ispell."
PKG_CAT="standard"

MY_PN=${PN/xemacs-/}

SRC_URI="ftp://ftp.xemacs.org/packages/${MY_PN}-${PV}-pkg.tar.gz"

RDEPEND=""
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

