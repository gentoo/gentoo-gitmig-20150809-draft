# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.4.4.ebuild,v 1.2 2004/04/15 23:34:27 randy Exp $

inherit distutils

DESCRIPTION="Several modules providing low level functionnalities shared among some python projects developped by logilab."
SRC_URI="ftp://ftp.logilab.org/pub/common/${P#logilab-}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/common/"

SLOT="0"
KEYWORDS="x86 s390"
LICENSE="GPL-2"
DEPEND=""

S=${WORKDIR}/${P#logilab-}

PYTHON_MODNAME="logilab"
DOCS=""
