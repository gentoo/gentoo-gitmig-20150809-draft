# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tix/tix-8.2.0.ebuild,v 1.5 2003/03/25 22:13:02 seemant Exp $

IUSE="tcl tk threads shared"
MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A widget library for Tcl/Tk. Has been ported to Python and Perl, too."
HOMEPAGE="http://sourceforge.net/projects/tixlibrary/"
SRC_URI="mirror://sourceforge/tixlibrary/tix8.2.0b1.tar.gz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="dev-lang/tk"
#RDEPEND=""

fix_makefile() {
	mv ${S}/$1/Makefile ${S}/$1/Makefile_orig
	sed -e "s:$2:$3:" \
		${S}/$1/Makefile_orig \
		> ${S}/$1/Makefile
}

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	cd ${S}/unix ; ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-gcc \
		--with-tcl=/usr/lib \
		--with-tk=/usr/lib \
		--enable-stubs \
		--enable-threads \
		--enable-shared || die "./configure failed"

	echo "##"
	echo "## Fixing the Makefile..."
	echo "##"
	fix_makefile unix	"\$(TK_SRC_DIR)"	"/usr/lib/tk8.3/include"

	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems).  Try emake first.  It might
	# not work for some packages, in which case you'll have to resort
	# to normal "make".
	make || die
	#make test || die
	#emake || die
}

src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	#make DESTDIR=${D} install || die
	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.
	#make install || die
	cd ${S}/unix ; einstall || die
}
