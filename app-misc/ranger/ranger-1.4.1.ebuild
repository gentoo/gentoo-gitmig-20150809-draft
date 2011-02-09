# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ranger/ranger-1.4.1.ebuild,v 1.1 2011/02/09 06:49:37 radhermit Exp $

EAPI=3
PYTHON_DEPEND="2:2.6 3:3.1"
PYTHON_USE_WITH="ncurses"

inherit distutils

DESCRIPTION="A vim-inspired file manager for the console"
HOMEPAGE="http://ranger.nongnu.org/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
