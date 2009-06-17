# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/klogview/klogview-0.6-r1.ebuild,v 1.3 2009/06/17 16:22:49 gentoofan23 Exp $

EAPI="2"

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A KDE utility for viewing log files in real time."
HOMEPAGE="http://klogview.sourceforge.net"
SRC_URI="mirror://sourceforge/klogview/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

need-kde 3
