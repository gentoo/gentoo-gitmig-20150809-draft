# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-3.3.1.ebuild,v 1.1 2004/01/18 01:43:40 pythonhead Exp $

IUSE="idl"

inherit distutils eutils

DESCRIPTION="eric3 is a full featured Python IDE that is written in PyQt using the QScintilla editor widget"
HOMEPAGE="http://www.die-offenbachs.de/detlev/eric3.html"
SRC_URI="http://www.die-offenbachs.de/detlev/files/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

distutils_python_version
IDIR="/usr/lib/python${PYVER}/site-packages/eric3/"
ADIR=${IDIR}"apis/"

DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.1
	>=dev-python/qscintilla-1.53
	>=dev-lang/python-2.2.1
	>=dev-python/sip-3.8
	>=dev-python/PyQt-3.8.1"

RDEPEND="${RDEPEND}
	idl? ( net-misc/omniORB )"

src_compile() {
	epatch ${FILESDIR}/install.py.${PF}.diff
}

src_install() {
	cp ${S}/patch_modpython.py ${S}/eric/Tools
	python install.py \
		-b /usr/bin \
		-i ${D}
	dodoc	HISTORY LICENSE.GPL THANKS eric/README*
}

pkg_postinst() {
	einfo ""
	einfo "Execute the command \"ebuild /var/db/pkg/dev-util/${PF}/${PF}.ebuild config\""
	einfo to generate the api files for the autocompletion/calltips feature of eric3.
	einfo "The api files will be placed in \"${ADIR}\"."
	einfo "You have to configure their usage in the eric3 Preferences Dialog -> Editor -> APIs."
	einfo ""
	einfo "If you want to use eric3 with Mod_python, have a look at"
	einfo "\"${IDIR}Tools/patch_modpython.py\"."
	einfo ""
}

pkg_config() {
	mkdir ${ADIR}
	einfo "Creating api files... (get a coffee)"
	python ${IDIR}Tools/gen_python_api.py ${ADIR}
	python ${IDIR}Tools/gen_pyqt_api.py /usr/share/sip ${ADIR}
}
