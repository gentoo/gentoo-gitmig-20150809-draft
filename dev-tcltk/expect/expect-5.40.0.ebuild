# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect/expect-5.40.0.ebuild,v 1.1 2004/04/04 22:13:08 zx Exp $

inherit gnuconfig

DESCRIPTION="tool for automating interactive applications"
HOMEPAGE="http://expect.nist.gov/"
SRC_URI="http://expect.nist.gov/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~amd64"
IUSE="X doc"

DEPEND=">=dev-lang/tcl-8.2
	X? ( >=dev-lang/tk-8.2 )"

S=${WORKDIR}/${P%.0}

src_compile() {
	if [ "${ARCH}" == "amd64" ]; then
		gnuconfig_update
	fi

	local myconf
	local tclv
	local tkv
	# Find the version of tcl/tk that has headers installed.
	# This will be the most recently merged, not necessarily the highest
	# version number.
	tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
	#tkv isn't really needed, included for symmetry and the future
	tkv=$( grep  TK_VER /usr/include/tk.h  | sed 's/^.*"\(.*\)".*/\1/')

	#configure needs to find the files tclConfig.sh and tclInt.h
	myconf="--with-tcl=/usr/lib --with-tclinclude=/usr/lib/tcl$tclv/include/generic"

	if use X; then
		#--with-x is enabled by default
		#configure needs to find the file tkConfig.sh and tk.h
		#tk.h is in /usr/lib so don't need to explicitly set --with-tkinclude
		myconf="$myconf --with-tk=/usr/lib"
	else
		#configure knows that tk depends on X so just disable X
		myconf="$myconf --without-x"
	fi

	econf $myconf --enable-shared || die
	emake || die
}

src_install () {
	einstall || die

	#docs
	dodoc Changelog FAQ HISTORY NEWS README

	#install examples if 'doc' is set
	if use doc; then
		cd ${S}
		dodir /usr/share/doc/${PF}/examples/
		cp example/* ${D}/usr/share/doc/${PF}/examples/
	fi
}
