# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/karchiver/karchiver-3.0.1.ebuild,v 1.2 2002/08/14 08:35:54 pvdabeel Exp $

DESCRIPTION="kArchiver is a KDE utility made to ease working with compressed files such as tar.gz, tar.bz2"
HOMEPAGE="http://perso.wanadoo.fr/coquelle/karchiver/"
SRC_URI="http://perso.wanadoo.fr/coquelle/karchiver/karchiver-3.0.1.tar.bz2"
LICENSE="GPL-1"
SLOT="3.0"
KEYWORDS="x86 ppc"
S="${WORKDIR}/${P}"

inherit kde-base || die 
need-kde 3
