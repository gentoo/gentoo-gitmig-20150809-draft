# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kebuild/kebuild-0.2.ebuild,v 1.9 2002/07/25 12:57:04 seemant Exp $

inherit kde-base || die

need-kde 3
DESCRIPTION="Graphical KDE emerge tool"
SRC_URI="mirror://sourceforge/kemerge/${P}.tar.gz"
HOMEPAGE="http://kemerge.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

newdepend ">=app-admin/kebuildpart-0.3-r1"
