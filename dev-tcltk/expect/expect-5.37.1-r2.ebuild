# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect/expect-5.37.1-r2.ebuild,v 1.8 2004/11/07 09:36:58 kumba Exp $

inherit gnuconfig

#remove the trailing ".0" from the tarball version
NON_MICRO_V=${P%.[0-9]}
S=${WORKDIR}/${NON_MICRO_V}

DESCRIPTION="tool for automating interactive applications"
HOMEPAGE="http://expect.nist.gov/"
SRC_URI="http://expect.nist.gov/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa amd64 ia64 s390"
IUSE="X doc"

DEPEND=">=dev-lang/tcl-8.2
	X? ( >=dev-lang/tk-8.2 )"

src_unpack() {
	unpack ${A}
	sed -i 's#/usr/local/bin#/usr/bin#' ${S}/expect.man
	sed -i 's#/usr/local/bin#/usr/bin#' ${S}/expectk.man
	#stops any example scripts being installed by default
	sed -i 's/^SCRIPTS =/G_SCRIPTS =/' ${S}/Makefile.in
	sed -i 's/^SCRIPTS_MANPAGES =/G_SCRIPTS_MANPAGES =/' ${S}/Makefile.in

	cat >${WORKDIR}/sed.examples.gentoo <<HERE
1s;#!\\.\\.;#!/usr/bin;
1s;#!/depot/path;#!/usr/bin;
HERE

	cat >${WORKDIR}/Makefile.examples.gentoo <<HERE
include Makefile

gentoo_examples:
	for i in \$(G_SCRIPTS) ; do \\
		if [ -f \$(srcdir)/example/\$\$i ] ; then \\
			\$(INSTALL_PROGRAM) \$(srcdir)/example/\$\$i \\
				${D}/usr/share/doc/${PF}/examples/\$\$i ; \\
			sed -i -f ${WORKDIR}/sed.examples.gentoo \\
						${D}/usr/share/doc/${PF}/examples/\$\$i ; \\
		fi ; \\
	done

	for i in \$(G_SCRIPTS_MANPAGES) ; do \\
		if [ -f \$(srcdir)/example/\$\$i.man ] ; then \\
			\$(INSTALL_DATA) \$(srcdir)/example/\$\$i.man \\
				${D}/usr/share/doc/${PF}/examples/\$\$i.1 ; \\
			gzip ${D}/usr/share/doc/${PF}/examples/\$\$i.1 ; \\
		fi ; \\
	done

HERE
}

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
	make install INSTALL_ROOT=${D} || die

	dodoc ChangeLog FAQ HISTORY NEWS README

	local static_lib="lib${NON_MICRO_V/-/}.a"
	rm ${D}/usr/lib/${NON_MICRO_V/-/}/${static_lib}

	#install examples if 'doc' is set
	if use doc; then
		docinto examples
		dodoc example/README
		make -f ${WORKDIR}/Makefile.examples.gentoo gentoo_examples
	fi
}
