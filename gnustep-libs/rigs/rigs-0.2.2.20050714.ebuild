# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/rigs/rigs-0.2.2.20050714.ebuild,v 1.4 2006/12/31 10:18:05 grobian Exp $

inherit gnustep

DESCRIPTION="Ruby Interface for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/RIGS.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~x86 ~ppc"
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"

IUSE="doc"
DEPEND="${GS_DEPEND}
	dev-lang/ruby"
RDEPEND="${GS_RDEPEND}
	dev-lang/ruby"

egnustep_install_domain "Local"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${P}-install-rb.patch
	epatch "${FILESDIR}"/${P}-compile.patch
}

src_install() {
	gnustep_src_install

	# install shared library
	RUBY_SITE_ARCH_DIR=$(ruby -rrbconfig -e 'print Config::CONFIG["sitearchdir"]')
	dodir ${RUBY_SITE_ARCH_DIR}
	cd ${S}/Source/obj
	if use debug; then
		#dolib librigs_d.so
		if [ "${GNUSTEP_FLATTENED}" ]; then
			dosym \
				${GNUSTEP_LOCAL_ROOT}/Library/Libraries/librigs_d.so \
				${RUBY_SITE_ARCH_DIR}/librigs.so
		else
			dosym \
				${GNUSTEP_LOCAL_ROOT}/Library/Libraries/${GNUSTEP_HOST_CPU}/${GNUSTEP_HOST_OS}/${LIBRARY_COMBO}/librigs_d.so \
				${RUBY_SITE_ARCH_DIR}/librigs.so
		fi
	else
		#dolib librigs.so
		if [ "${GNUSTEP_FLATTENED}" ]; then
			dosym \
				${GNUSTEP_LOCAL_ROOT}/Library/Libraries/librigs.so \
				${RUBY_SITE_ARCH_DIR}/librigs.so
		else
			dosym \
				${GNUSTEP_LOCAL_ROOT}/Library/Libraries/${GNUSTEP_HOST_CPU}/${GNUSTEP_HOST_OS}/${LIBRARY_COMBO}/librigs.so \
				${RUBY_SITE_ARCH_DIR}/librigs.so
		fi
	fi

	# Install .rb files
	RUBY_SITE_LIB_DIR=$(ruby -rrbconfig -e 'print Config::CONFIG["sitelibdir"]')
	dodir ${RUBY_SITE_LIB_DIR}/rigs
	cd ${S}/Ruby
	cp -f rigs.rb Foundation.rb AppKit.rb ${D}/${RUBY_SITE_LIB_DIR}
	cd ${S}/Ruby/rigs
	RB_FILES=$(ls *.rb -1 --color=never)
	cp -f ${RB_FILES} ${D}/${RUBY_SITE_LIB_DIR}/rigs

	# install examples
	if use doc; then
		cd ${S}
		dodir ${GNUSTEP_LOCAL_ROOT}/Library/Documentation/RIGS
		cp -pPR Examples ${D}/${GNUSTEP_LOCAL_ROOT}/Library/Documentation/RIGS
		rm -Rf \
			${D}/${GNUSTEP_LOCAL_ROOT}/Library/Documentation/RIGS/Examples/CVS \
			${D}/${GNUSTEP_LOCAL_ROOT}/Library/Documentation/RIGS/Examples/Base/CVS \
			${D}/${GNUSTEP_LOCAL_ROOT}/Library/Documentation/RIGS/Examples/Gui/CVS
	fi
}
