# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ktelnet/ktelnet-2.0.43-r1.ebuild,v 1.3 2002/05/21 18:14:11 danarmak Exp $

inherit kde-base || die

need-kdelibs 2.1.1

DESCRIPTION="A Putty like for KDE"
SRC_URI="http://www.spaghetti-code.de/download/ktelnet/${PN}2-0.43.tgz"
HOMEPAGE="http://www.spaghetti-code.de/software/linux/ktelnet/"

S=${WORKDIR}/ktelnet2-0.43