# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psyco/psyco-1.0.0_beta1.ebuild,v 1.7 2004/12/01 00:22:26 pythonhead Exp $

inherit distutils

PSYCO=${P/_beta/b}

HOMEPAGE="http://psyco.sourceforge.net/"
DESCRIPTION="Psyco is a Python extension module which can massively speed up the execution of any Python code."

SRC_URI="mirror://sourceforge/psyco/${PSYCO}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
DEPEND="<dev-lang/python-2.4
	!dev-python/psyco-cvs"
S=${WORKDIR}/${PSYCO}
