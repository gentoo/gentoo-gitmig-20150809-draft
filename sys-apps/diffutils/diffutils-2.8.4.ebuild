# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.8.4.ebuild,v 1.1 2002/09/25 12:47:39 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://alpha.gnu.org/gnu/diffutils/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"

KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	!build? ( sys-apps/texinfo )"

RDEPEND="virtual/glibc"


src_unpack() {
	unpack ${A}

	cd ${S}
	if [ -n "`use build`" ]
	then
		#disable texinfo building so we can remove the dep
		cp Makefile.in Makefile.in.orig
		sed -e 's:SUBDIRS = doc:SUBDIRS =:' \
			Makefile.in.orig > Makefile.in
	fi
}

src_compile() {
	local myconf=""
	[ -z "`use nls`" ] && myconf="--disable-nls"
	
	econf --build=${CHOST} \
		${myconf} || die
		
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
		
	if [ -z "`use build`" ]
	then
		dodoc COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share/info
	fi
}

