# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/helpviewer/helpviewer-0.3-r1.ebuild,v 1.2 2004/11/12 03:54:20 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${P/helpv/HelpV}

DESCRIPTION="HelpViewer is an online help viewer for GNUstep programs."
HOMEPAGE="http://www.roard.com/helpviewer/"
SRC_URI="http://www.roard.com/helpviewer/download/${P/helpv/HelpV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
DEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

