# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons-cvs/scons-cvs-0.96-r1.ebuild,v 1.2 2004/07/15 00:06:37 agriffis Exp $

inherit cvs python distutils

DESCRIPTION="Extensible python-based build utility"
SRC_URI=""
RESTRICT="nomirror"
HOMEPAGE="http://www.scons.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

DEPEND=">=dev-lang/python-2.0
	!dev-util/scons"
PROVIDE="dev-util/scons"

DOCS="RELEASE.txt CHANGES.txt LICENSE.txt"

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/scons"
ECVS_MODULE="scons"
ECVS_AUTH="pserver"
S=${WORKDIR}/scons

src_compile(){
	SCONS_LIB_DIR=`pwd`/src/engine python src/script/scons.py build/scons || die
	cd build/scons || die
	distutils_src_compile
}

src_install () {
	cd build/scons || die
	distutils_src_install
	doman scons.1 sconsign.1
}

pkg_postinst() {
	python_mod_optimize /usr/lib/scons/SCons
}

pkg_postrm() {
	python_mod_cleanup
}
