# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-3.4.2.ebuild,v 1.6 2004/07/23 19:47:46 carlo Exp $

IUSE="idl"

inherit python eutils

DESCRIPTION="eric3 is a full featured Python IDE that is written in PyQt using the QScintilla editor widget"
HOMEPAGE="http://www.die-offenbachs.de/detlev/eric3.html"
SRC_URI="http://www.die-offenbachs.de/detlev/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

python_version
IDIR="/usr/lib/python${PYVER}/site-packages/eric3/"

DEPEND="virtual/libc
	sys-devel/libtool
	>=x11-libs/qt-3.1
	>=dev-python/qscintilla-1.54
	>=dev-lang/python-2.2.3
	>=dev-python/sip-3.8
	>=dev-python/PyQt-3.8.1"

RDEPEND="idl? ( !sparc? ( >=net-misc/omniORB-4.0.3 ) )"

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
	einfo ""
	einfo "If you want to use eric3 with mod_python, have a look at"
	einfo "\"${IDIR}Tools/patch_modpython.py\"."
	einfo ""
}
