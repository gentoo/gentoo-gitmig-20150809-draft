# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/generator/generator-1.0.ebuild,v 1.1 2003/10/11 06:11:00 robbat2 Exp $
IUSE=""
DESCRIPTION="widget generator for Archetypes"
SRC_URI="mirror://sourceforge/archetypes/${P}.tar.gz"
S=${WORKDIR}/${P}
LICENSE="GPL-2"
KEYWORDS="~x86"
if [ "${PYTHON_SLOT_VERSION}" = 'VIRTUAL' ] ; then
	RDEPEND="virtual/python"
else
	RDEPEND="dev-lang/python"
fi
DEPEND="${RDEPEND}"
SLOT=0

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

