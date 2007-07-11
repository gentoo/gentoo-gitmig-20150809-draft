# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-ispell/xemacs-ispell-1.32.ebuild,v 1.5 2007/07/11 02:37:38 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Spell-checking with GNU ispell."
PKG_CAT="standard"

MY_PN=${PN/xemacs-/}

SRC_URI="http://ftp.xemacs.org/packages/${MY_PN}-${PV}-pkg.tar.gz"

RDEPEND=""
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
