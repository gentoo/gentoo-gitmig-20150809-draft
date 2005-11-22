# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/confcache/confcache-0.3.3.ebuild,v 1.1 2005/11/22 04:33:36 ferringb Exp $

inherit distutils

DESCRIPTION="global autoconf cache manager"
HOMEPAGE="http://dev.gentoo.org/~ferringb/${PN}"
SRC_URI="http://dev.gentoo.org/~ferringb/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.2"
RDEPEND=">=dev-lang/python-2.2 >=sys-apps/sandbox-1.2.12"
S=${WORKDIR}/${P}

