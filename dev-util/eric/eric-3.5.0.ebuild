# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-3.5.0.ebuild,v 1.3 2004/11/23 19:13:10 carlo Exp $

inherit python

DESCRIPTION="eric3 is a full featured Python IDE that is written in PyQt using the QScintilla editor widget"
HOMEPAGE="http://www.die-offenbachs.de/detlev/eric3.html"
SRC_URI="mirror://sourceforge/eric-ide/${P}.tar.gz
	linguas_de? ( mirror://sourceforge/eric-ide/${PN}-i18n-de-${PV}.tar.gz )
	linguas_fr? ( mirror://sourceforge/eric-ide/${PN}-i18n-fr-${PV}.tar.gz )
	linguas_ru? ( mirror://sourceforge/eric-ide/${PN}-i18n-ru-${PV}.tar.gz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~amd64 ~ppc64"
IUSE="idl"

python_version
IDIR="/usr/lib/python${PYVER}/site-packages/eric3/"

DEPEND="virtual/libc
	sys-devel/libtool
	>=dev-python/qscintilla-1.54
	>=dev-python/sip-3.10.2
	>=dev-python/PyQt-3.12"

RDEPEND=">=dev-python/qscintilla-1.54
	>=dev-lang/python-2.2.3
	>=dev-python/sip-3.10.2
	idl? ( !sparc? ( >=net-misc/omniORB-4.0.3 ) )"

src_install() {
	python install.py \
		-b /usr/bin \
		-i ${D} \
		-c
	dodir "${IDIR}Tools"
	cp ${S}/patch_modpython.py ${D}/${IDIR}Tools
	dodoc	HISTORY LICENSE.GPL THANKS eric/README*
}

pkg_postinst() {
	echo ""
	einfo "If you want to use eric3 with mod_python, have a look at"
	einfo "\"${IDIR}Tools/patch_modpython.py\"."
	echo ""
}
