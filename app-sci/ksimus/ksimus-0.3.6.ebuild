# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ksimus/ksimus-0.3.6.ebuild,v 1.1 2003/04/15 14:21:07 phosphan Exp $

inherit kde-base

DESCRIPTION="KSimus is a KDE tool for simulation, automatization and visualization of technical processes."
HOMEPAGE="http://ksimus.berlios.de/"
KEYWORDS="~x86"
SRC_URI="http://ksimus.berlios.de/download/ksimus-3-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc" # stop complaining, we need kde - see below

need-kde 3
