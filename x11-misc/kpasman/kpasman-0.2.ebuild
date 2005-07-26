# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kpasman/kpasman-0.2.ebuild,v 1.8 2005/07/26 14:43:24 dholm Exp $

inherit kde

DESCRIPTION="Kpasman is a small password manager for the K Desktop Environment"
SRC_URI="mirror://sourceforge/kpasman/${P}.tar.gz"
HOMEPAGE="http://kpasman.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

need-kde 3

