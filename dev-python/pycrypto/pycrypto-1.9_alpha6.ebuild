# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrypto/pycrypto-1.9_alpha6.ebuild,v 1.8 2003/12/17 00:11:23 weeve Exp $

inherit distutils
IUSE=""

DESCRIPTION="Python cryptography toolkit."
HOMEPAGE="http://www.amk.ca/python/code/crypto.html"
## NOTE: I'm getting 403's with this link, but it works if the
##        referrer is his homepage. Grr! Mirroring on Gentoo
# SRC_URI="http://www.amk.ca/files/python/${P/_alpha/a}.tar.gz"
SRC_URI="mirror://gentoo/${P/_alpha/a}.tar.gz"
LICENSE="freedist"

DEPEND="virtual/glibc
	dev-lang/python"

SLOT="0"
KEYWORDS="x86 ~alpha ~sparc"
S="${WORKDIR}/${P/_alpha/a}"

mydoc="ACKS ChangeLog LICENSE MANIFEST PKG-INFO README TODO"
