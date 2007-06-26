# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/generator/generator-1.2.3.ebuild,v 1.7 2007/06/26 01:59:18 mr_bones_ Exp $
SLOT="0"
IUSE=""
DESCRIPTION="Widget generator for Archetypes"
HOMEPAGE="http://www.sourceforge.net/projects/archetypes"
SRC_PN=archetypes
SRC_PV=1.2.3_final
SRC_P=${SRC_PN}-${SRC_PV}
SRC_URI="mirror://sourceforge/${SRC_PN}/${SRC_P}.tgz"
S=${WORKDIR}/${SRC_P}/${PN}
LICENSE="GPL-2"
KEYWORDS="~ia64 ~ppc ~x86"
if [ "${PYTHON_SLOT_VERSION}" = 'VIRTUAL' ] ; then
	DEPEND="virtual/python"
else
	DEPEND="dev-lang/python"
fi

src_install() {
	local python=""
	if [ "${PYTHON_SLOT_VERSION}" = 'VIRTUAL' ] ; then
		python='python'
		einfo "Building with virtual python"
	else
		if has_version '=dev-lang/python-2.1*'; then
			python="${python} python2.1"
			einfo "Building with Python 2.1"
		fi
		if has_version '=dev-lang/python-2.2*'; then
			python="${python} python2.2"
			einfo "Building with Python 2.2"
		fi
	fi

	for i in ${python}; do
		$i setup.py clean
		# ok, so this actually compiles them here, but it was the only way I could find to
		# compile both versions
		$i setup.py build install --prefix=${D}/usr || die
	done;
	dodoc ChangeLog PKG-INFO README
}
