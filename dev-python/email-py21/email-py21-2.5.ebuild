# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/email-py21/email-py21-2.5.ebuild,v 1.3 2003/06/22 12:15:59 liquidx Exp $

# Python 2.2.2 and 2.3 come with email version 2, while earlier versions of 
# Python 2.2.x come with email version 1. Python 2.1.x and earlier do not come
# with any version of the email package.

PYTHON_SLOT_VERSION=2.1

inherit distutils
P_NEW="${PN%-py21}-${PV/_pre/pre}"
S=${WORKDIR}/${P_NEW}

DESCRIPTION="Helps to create, parse, generate, and modify email messages."
HOMEPAGE="http://mimelib.sourceforge.net/"
SRC_URI="mirror://sourceforge/mimelib/${P_NEW}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="PSF-2.2"
IUSE=""
