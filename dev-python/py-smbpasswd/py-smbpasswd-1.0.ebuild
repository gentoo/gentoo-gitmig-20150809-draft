# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-smbpasswd/py-smbpasswd-1.0.ebuild,v 1.5 2005/05/22 21:11:22 weeve Exp $

inherit distutils

DESCRIPTION="This module can generate both LANMAN and NT password hashes, suitable for use with Samba."
HOMEPAGE="http://barryp.org/software/py-smbpasswd/"
SRC_URI="http://barryp.org/software/py-smbpasswd/files/py-smbpasswd-1.0.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc ~sparc x86"
IUSE=""

DEPEND="virtual/python"
