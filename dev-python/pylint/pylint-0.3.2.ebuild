# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.3.2.ebuild,v 1.1 2004/02/17 20:49:43 kloeri Exp $

inherit distutils

DESCRIPTION="PyLint is a python tool that checks if a module satisfy a coding standard"
SRC_URI="ftp://ftp.logilab.org/pub/pylint/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pylint/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
DEPEND=">=dev-python/optik-1.4
	>=dev-python/logilab-common-0.3.4"
