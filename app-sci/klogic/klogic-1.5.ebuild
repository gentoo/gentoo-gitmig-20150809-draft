# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/klogic/klogic-1.5.ebuild,v 1.1 2003/04/24 17:27:36 caleb Exp $

inherit kde-base

DESCRIPTION="KLogic is an application for easy creation and simulation of electrical circuits"
HOMEPAGE="http://www.a-rostin.de/klogic/"
KEYWORDS="~x86"
SRC_URI="http://www.a-rostin.de/klogic/Version/${P}.tar.gz"

LICENSE="GPL-2"

need-kde 3
