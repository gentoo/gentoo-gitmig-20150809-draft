# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythondialog/pythondialog-2.7.ebuild,v 1.4 2004/11/18 04:21:42 jhuebel Exp $

inherit eutils distutils

DESCRIPTION="A Python module for making simple text/console-mode user interfaces."
HOMEPAGE="http://pythondialog.sourceforge.net/"
SRC_URI="mirror://sourceforge/pythondialog/${PF}.tar.bz2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"
LICENSE="LGPL-2"
IUSE=""

DEPEND="virtual/python
	dev-util/dialog"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -ie "s:/usr/local:/usr:g" setup.cfg
}
