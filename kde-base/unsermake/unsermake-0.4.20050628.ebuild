# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/unsermake/unsermake-0.4.20050628.ebuild,v 1.1 2005/06/29 02:09:08 caleb Exp $

inherit python

IUSE=""
DESCRIPTION="Unsermake - Advanced KDE build system"
HOMEPAGE="http://wiki.kde.org/tiki-index.php?page=unsermake"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
S=${WORKDIR}/unsermake

DEPEND=">=dev-lang/python-2.2
	!<kde-base/kdelibs-3.4"
RDEPEND="$DEPEND"

src_compile()
{
	return
}

src_install()
{
	python_version
	dodir /usr/lib/python${PYVER}/site-packages/unsermake
	cp -a ${S}/*.py ${D}/usr/lib/python${PYVER}/site-packages/unsermake
	cp -a ${S}/*.um ${D}/usr/lib/python${PYVER}/site-packages/unsermake
	dodir /usr/bin
	cp -a ${S}/unsermake ${D}/usr/bin
}

pkg_postinst()
{
	einfo "Unsermake builds are highly experimental; use at your own risk"
}
