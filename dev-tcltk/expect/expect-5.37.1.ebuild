# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect/expect-5.37.1.ebuild,v 1.8 2003/04/23 16:01:36 vapier Exp $

#remove the trailing ".0" from the tarball version
S=${WORKDIR}/${P%.1}

DESCRIPTION="tool for automating interactive applications"
SRC_URI="http://expect.nist.gov/src/${P}.tar.gz"
HOMEPAGE="http://expect.nist.gov/"

SLOT="0"
KEYWORDS="x86 sparc"
LICENSE="BSD"
IUSE="X"

DEPEND=">=dev-lang/tcl-8.2
	X? ( >=dev-lang/tk-8.2 )"

src_compile() {
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
	
	if [ `use X` ]; then
		#--with-x is enabled by default
		#configure needs to find the file tkConfig.sh and tk.h
		#tk.h is in /usr/lib so don't need to explicitly set --with-tkinclude
		myconf="${myconf} --with-tk=/usr/lib"
	else
		#configure knows that tk depends on X so just disable X
		myconf="${myconf} --without-x"
	fi

	econf ${myconf} || die	
	emake || die
}

src_install() {
	einstall || die
	dodoc Changelog FAQ HISTORY NEWS README
}
