# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/karchiver/karchiver-3.0.1.ebuild,v 1.6 2003/02/14 08:10:31 vapier Exp $

inherit kde-base || die 
need-kde 3

DESCRIPTION="utility to ease working with compressed files such as tar.gz/tar.bz2"
HOMEPAGE="http://perso.wanadoo.fr/coquelle/karchiver/"
SRC_URI="http://perso.wanadoo.fr/coquelle/karchiver/${P}.tar.bz2"

LICENSE="GPL-1"
SLOT="3.0"
KEYWORDS="x86 ppc sparc"
