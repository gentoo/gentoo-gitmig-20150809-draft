# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kpasman/kpasman-0.2.ebuild,v 1.1 2003/05/29 03:02:43 caleb Exp $

inherit kde-base 

S=${WORKDIR}/${P}
DESCRIPTION="Kpasman is a small password manager for the K Desktop Environment"
SRC_URI="mirror://sourceforge/kpasman/${P}.tar.gz"
HOMEPAGE="http://kpasman.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3

