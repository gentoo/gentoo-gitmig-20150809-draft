# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.3.4.ebuild,v 1.5 2004/06/25 01:33:20 agriffis Exp $

inherit distutils

DESCRIPTION="Several modules providing low level functionnalities shared among some python projects developped by logilab."
SRC_URI="ftp://ftp.logilab.org/pub/common/${P#logilab-}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/common/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
DEPEND=""
IUSE=""

S=${WORKDIR}/${P#logilab-}

PYTHON_MODNAME="logilab"
DOCS=""
