# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/rigs/rigs-0.2.2.20050714-r1.ebuild,v 1.4 2008/01/30 01:40:27 ranger Exp $

inherit gnustep-2

DESCRIPTION="Ruby Interface for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/RIGS.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~amd64 ppc x86"
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"

DEPEND="dev-lang/ruby"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-install-rb.patch
	epatch "${FILESDIR}"/${P}-compile.patch
}

src_install() {
	gnustep-base_src_install

	# install shared library
	RUBY_SITE_ARCH_DIR=$(ruby -rrbconfig -e 'print Config::CONFIG["sitearchdir"]')
	dodir ${RUBY_SITE_ARCH_DIR}
	cd "${S}"/Source/obj
	if use debug; then
		dosym \
		${GNUSTEP_SYSTEM_LIBRARIES}/librigs_d.so \
		${RUBY_SITE_ARCH_DIR}/librigs.so
	else
		dosym \
		${GNUSTEP_SYSTEM_LIBRARIES}/librigs.so \
		${RUBY_SITE_ARCH_DIR}/librigs.so
	fi

	# Install .rb files
	RUBY_SITE_LIB_DIR=$(ruby -rrbconfig -e 'print Config::CONFIG["sitelibdir"]')
	dodir ${RUBY_SITE_LIB_DIR}/rigs
	cd "${S}"/Ruby
	cp -f rigs.rb Foundation.rb AppKit.rb "${D}"/${RUBY_SITE_LIB_DIR}
	cd "${S}"/Ruby/rigs
	RB_FILES=$(ls *.rb -1 --color=never)
	cp -f ${RB_FILES} "${D}"/${RUBY_SITE_LIB_DIR}/rigs

	# install examples
	if use doc; then
		cd "${S}"
		dodir ${GNUSTEP_SYSTEM_DOC}/RIGS
		cp -pPR Examples "${D}"/${GNUSTEP_SYSTEM_DOC}/RIGS
		rm -Rf \
		"${D}"/${GNUSTEP_SYSTEM_DOC}/RIGS/Examples/CVS \
		"${D}"/${GNUSTEP_SYSTEM_DOC}/RIGS/Examples/Base/CVS \
		"${D}"/${GNUSTEP_SYSTEM_DOC}/RIGS/Examples/Gui/CVS
	fi
}
