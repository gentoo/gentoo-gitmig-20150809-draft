# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.18.1-r2.ebuild,v 1.2 2003/05/09 01:57:54 gmsoft Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Text formatter used for man pages"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/groff/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips hppa ~arm"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-apps/texinfo-4.0"

PDEPEND=">=sys-apps/man-1.5k-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix the info pages to have .info extensions,
	# else they do not get gzipped.
	epatch ${FILESDIR}/groff-1.18-infoext.patch

	# Do not generate example files that require us to
	# depend on netpbm.
	epatch ${FILESDIR}/groff-1.18-no-netpbm-depend.patch

	# Do not segfault if no color is defined in input, bug #14329
	# <azarah@gentoo.org> (08 Feb 2003)
	epatch ${FILESDIR}/${P}-no-color-segfault.patch

	# Make dashes the same as minus on the keyboard so that you
	# can search for it. Fixes #17580 and #16108
	# Thanks to James Cloos <cloos@jhcloos.com>
	epatch ${FILESDIR}/${PN}-man-UTF-8.diff
}

src_compile() {
	# Fix problems with not finding g++
	[ -z "${CC}" ] && export CC="gcc"
	[ -z "${CXX}" ] && export CXX="g++"

	#-march=2.0 makes groff unable to finish the compile process
	if [ "${ARCH}" = "hppa" ]; then
		export CFLAGS="${CFLAGS/-march=2.0/}"
		export CXXFLAGS="${CXXFLAGS/-march=2.0/}"
	fi
						

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=\${inforoot} || die
		
	# emake doesn't work
	make || die

	# Only build X stuff if we have X installed, but do
	# not depend on it, else we get circular deps.
	if [ -n "`use X`" ] && [ -x /usr/X11R6/bin/xmkmf ]
	then
		cd ${S}/src/xditview
		xmkmf || die
		make depend all || die
	fi
}

src_install() {
	dodir /usr /usr/share/doc/${PF}/{examples,html}
	make prefix=${D}/usr \
		manroot=${D}/usr/share/man \
		inforoot=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${PF} \
		install || die

	if [ -n "`use X`" ] && [ -x /usr/X11R6/bin/xmkmf ]
	then
		cd ${S}/src/xditview
		make DESTDIR=${D} \
			BINDIR=/usr/bin \
			MANPATH=/usr/share/man \
			install \
			install.man || die
	fi
	
	#the following links are required for xman
	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl
	dosym soelim /usr/bin/zsoelim

	cd ${S}
	dodoc BUG-REPORT COPYING ChangeLog FDL MORE.STUFF NEWS \
		PROBLEMS PROJECTS README REVISION TODO VERSION
}

