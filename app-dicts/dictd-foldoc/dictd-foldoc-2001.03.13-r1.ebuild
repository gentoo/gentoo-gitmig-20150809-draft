# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-foldoc/dictd-foldoc-2001.03.13-r1.ebuild,v 1.11 2005/01/01 12:49:17 eradicator Exp $

MY_P=foldoc-20010313
DESCRIPTION="The Free On-line Dictionary of Computing for dict"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc amd64"

DEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}

src_install() {
	insinto /usr/lib/dict
	doins foldoc.dict.dz foldoc.index || die
}
