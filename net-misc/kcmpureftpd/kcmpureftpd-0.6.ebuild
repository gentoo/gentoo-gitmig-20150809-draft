# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kcmpureftpd/kcmpureftpd-0.6.ebuild,v 1.3 2002/05/27 17:27:39 drobbins Exp $

inherit kde-base || die

need-kde 2.1

DESCRIPTION="Pure-FTPd KDE Kcontrol Configuration Panel"
SRC_URI="mirror://sourceforge/pureftpd/${P}.tar.gz"
HOMEPAGE="http://lkr.sourceforge.net/kcmpureftpd/index.html"
