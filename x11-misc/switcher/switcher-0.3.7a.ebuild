# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/switcher/switcher-0.3.7a.ebuild,v 1.3 2004/03/14 17:32:02 mr_bones_ Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A small KDE app for switching the order of letters (as in logical and visual hebrew)"
HOMEPAGE="http://www.penguin.org.il/~uvgroovy/"
SRC_URI="http://www.penguin.org.il/~uvgroovy/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND="${RDEPEND}"

S=${WORKDIR}/${P}
