# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/email-py21/email-py21-2.5.ebuild,v 1.6 2003/09/08 07:16:26 msterret Exp $

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

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="x86 ppc"
