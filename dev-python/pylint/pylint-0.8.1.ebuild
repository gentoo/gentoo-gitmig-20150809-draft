# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-0.8.1.ebuild,v 1.2 2005/11/08 17:08:46 pythonhead Exp $

inherit distutils

DESCRIPTION="PyLint is a tool to check if a Pyhon module satisfies a coding standard"
SRC_URI="ftp://ftp.logilab.org/pub/pylint/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pylint/"

IUSE=""
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
DEPEND="|| ( >=dev-python/optik-1.4 >=dev-lang/python-2.3 )
		>=dev-python/logilab-common-0.9.3
		>=dev-python/astng-0.13.1"

DOCS="doc/*.txt"

