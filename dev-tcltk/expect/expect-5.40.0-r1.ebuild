# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect/expect-5.40.0-r1.ebuild,v 1.2 2004/07/14 21:43:03 mr_bones_ Exp $

inherit gnuconfig

DESCRIPTION="tool for automating interactive applications"
HOMEPAGE="http://expect.nist.gov/"
SRC_URI="http://expect.nist.gov/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~amd64 ~ppc64"
IUSE="X doc"

DEPEND=">=dev-lang/tcl-8.2
	X? ( >=dev-lang/tk-8.2 )"

NON_MICRO_V=${P%.[0-9]}
S=${WORKDIR}/${NON_MICRO_V}

src_unpack() {
	unpack ${A}
	sed -i 's#/usr/local/bin#/usr/bin#' ${S}/expect.man
	sed -i 's#/usr/local/bin#/usr/bin#' ${S}/expectk.man
	#stops any example scripts being installed by default
	sed -i '/^install:/s/install-libraries //' ${S}/Makefile.in
	sed -i 's/^SCRIPTS_MANPAGES = /_&/' ${S}/Makefile.in
}

src_compile() {
	use amd64 && gnuconfig_update
	use ppc64 && gnuconfig_update

	local myconf
	local tclv
	local tkv
	# Find the version of tcl/tk that has headers installed.
	# This will be the most recently merged, not necessarily the highest
	# version number.
	tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
	#tkv isn't really needed, included for symmetry and the future
	#tkv=$(grep  TK_VER /usr/include/tk.h  | sed 's/^.*"\(.*\)".*/\1/')

	#configure needs to find the files tclConfig.sh and tclInt.h
	myconf="--with-tcl=/usr/lib --with-tclinclude=/usr/lib/tcl${tclv}/include/generic"

	if use X; then
		#--with-x is enabled by default
		#configure needs to find the file tkConfig.sh and tk.h
		#tk.h is in /usr/lib so don't need to explicitly set --with-tkinclude
		myconf="$myconf --with-tk=/usr/lib"
	else
		#configure knows that tk depends on X so just disable X
		myconf="$myconf --without-x"
	fi

	econf $myconf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make install INSTALL_ROOT=${D} || die "make install failed"

	dodoc ChangeLog FAQ HISTORY NEWS README

	local static_lib="lib${NON_MICRO_V/-/}.a"
	rm ${D}/usr/lib/${NON_MICRO_V/-/}/${static_lib}

	#install examples if 'doc' is set
	if use doc; then
		docinto examples
		local scripts=$(make -qp | \
		                sed -e 's/^SCRIPTS = //' -et -ed | head -n1)
		exeinto /usr/share/doc/${PF}/examples
		doexe ${scripts}
		local scripts_manpages=$(make -qp | \
		       sed -e 's/^_SCRIPTS_MANPAGES = //' -et -ed | head -n1)
		for m in ${scripts_manpages}; do
			dodoc example/${m}.man
		done
		dodoc example/README
	fi

}
