# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/unsermake/unsermake-0.4.20050710.ebuild,v 1.4 2007/01/05 17:00:44 flameeyes Exp $

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
RDEPEND="${RDEPEND}"

src_compile()
{
	return
}

src_install()
{
	python_version
	UNSERMAKEDIR=/usr/lib/python${PYVER}/site-packages/unsermake/
	dodir ${UNSERMAKEDIR}
	cp -pPR ${S}/*.py ${D}/${UNSERMAKEDIR}
	cp -pPR ${S}/*.um ${D}/${UNSERMAKEDIR}
	cp -pPR ${S}/unsermake ${D}/${UNSERMAKEDIR}
	dodir /usr/bin
	dosym ${UNSERMAKEDIR}/unsermake /usr/bin/unsermake
}

pkg_postinst()
{
	elog "Unsermake builds are highly experimental; use at your own risk"
}
