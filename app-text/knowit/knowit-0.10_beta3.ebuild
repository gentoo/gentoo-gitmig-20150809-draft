# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/knowit/knowit-0.10_beta3.ebuild,v 1.1 2004/01/22 02:41:24 caleb Exp $

inherit kde-base
need-kde 3

MY_P=${P/_/}
DESCRIPTION="KnowIt is a simple tool for managing notes - similar to TuxCards but KDE based."
SRC_URI="http://knowit.sourceforge.net/files/${MY_P}.tar.bz2"
HOMEPAGE="http://knowit.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86"

S=$WORKDIR/${MY_P}
