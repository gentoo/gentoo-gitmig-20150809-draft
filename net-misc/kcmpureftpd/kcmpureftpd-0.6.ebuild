# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kcmpureftpd/kcmpureftpd-0.6.ebuild,v 1.10 2003/02/13 14:55:03 vapier Exp $

inherit kde-base || die

need-kde 2.1

KEYWORDS="x86 sparc "
LICENSE="GPL-2"
DESCRIPTION="Pure-FTPd KDE Kcontrol Configuration Panel"
SRC_URI="mirror://sourceforge/pureftpd/${P}.tar.gz"
HOMEPAGE="http://lkr.sourceforge.net/kcmpureftpd/index.html"
