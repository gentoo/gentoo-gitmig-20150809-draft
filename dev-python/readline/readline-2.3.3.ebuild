# Copyright 1999-2004 Gentoo Foundation, Pieter Van den Abeele <pvdabeel@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/readline/readline-2.3.3.ebuild,v 1.4 2004/08/03 11:50:51 dholm Exp $

inherit distutils

DESCRIPTION="add readline support to python"
HOMEPAGE="http://www.opensource.apple.com/darwinsource/"
SRC_URI="http://www.metadistribution.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* macos ~ppc"
IUSE=""

DEPEND=">=sys-libs/readline-4.3
	>=dev-lang/python-2.3.3"
