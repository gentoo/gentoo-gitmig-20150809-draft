# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/unsermake/unsermake-0.4.20050628-r1.ebuild,v 1.1 2005/06/29 14:53:51 caleb Exp $

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
	UNSERMAKEDIR=/usr/lib/python${PYVER}/site-packages/unsermake/
	dodir ${UNSERMAKEDIR}
	cp -a ${S}/*.py ${D}/${UNSERMAKEDIR}
	cp -a ${S}/*.um ${D}/${UNSERMAKEDIR}
	cp -a ${S}/unsermake ${D}/${UNSERMAKEDIR}
	dodir /usr/bin
	dosym ${UNSERMAKEDIR}/unsermake /usr/bin/unsermake
}

pkg_postinst()
{
	einfo "Unsermake builds are highly experimental; use at your own risk"
}
