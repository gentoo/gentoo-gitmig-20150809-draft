# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kpasman/kpasman-0.2.ebuild,v 1.5 2004/06/19 14:06:26 pyrania Exp $

inherit kde

DESCRIPTION="Kpasman is a small password manager for the K Desktop Environment"
SRC_URI="mirror://sourceforge/kpasman/${P}.tar.gz"
HOMEPAGE="http://kpasman.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

need-kde 3

