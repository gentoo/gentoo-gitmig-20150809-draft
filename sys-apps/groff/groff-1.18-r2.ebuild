# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.18-r2.ebuild,v 1.3 2003/06/21 21:19:39 drobbins Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Text formatter used for man pages"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/groff/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"

KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha ~mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	media-libs/netpbm"

src_unpack() {
	unpack ${A}

	# Fix the info pages to have .info extensions,
	# else they do not get gzipped.
	cd ${S}
	epatch ${FILESDIR}/${P}-infoext.patch
}

src_compile() {
	# Fix problems with not finding g++
	[ -z "${CC}" ] && export CC="gcc"
	[ -z "${CXX}" ] && export CXX="g++"
	
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

