# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/charles/charles-20050913.ebuild,v 1.3 2007/05/28 19:03:44 george Exp $

inherit gnat

IUSE=""

DESCRIPTION="Posix bindings for Ada"
HOMEPAGE="http://libre2.adacore.com/"
SRC_URI="http://dev.gentoo.org/~george/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/gnat"

S="${WORKDIR}/${PN}"

lib_compile()
{
	einfo "nothing to do here"
}

# NOTE: we are using $1 - the passed gnat profile name
lib_install()
{
	einfo "nothing to do here"
}

src_install ()
{
	# install sources
	dodir ${AdalibSpecsDir}/${PN}
	insinto ${AdalibSpecsDir}/${PN}
	doins src/*.ad?

	#set up environment
	#echo "PATH=%DL%/bin" > ${LibEnv}
	#echo "LDPATH=%DL%" >> ${LibEnv}
	#echo "ADA_OBJECTS_PATH=%DL%" >> ${LibEnv}
	echo "ADA_INCLUDE_PATH=/usr/include/ada/${PN}" > ${LibEnv}

	gnat_src_install

	dodoc src/{COPYING.TXT,README.txt}
	insinto /usr/share/doc/${PF}
	doins -r src/testdir/ www/charles_tutorial.pdf
}
