# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jless-iso254/jless-iso254-358.ebuild,v 1.6 2003/07/30 17:33:46 usata Exp $

KEYWORDS="x86 ~alpha ~sparc ~ppc"
A=less-${PV}.tar.gz
S=${WORKDIR}/less-${PV}
DESCRIPTION="Japanese enabled pager -- less-iso254"

SRC_URI="ftp://ftp.gnu.org/pub/gnu/less/less-${PV}.tar.gz
	http://www.io.com/~kazushi/less/less-358-iso254.patch.gz"
HOMEPAGE="http://www.io.com/~kazushi/less/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"
LICENSE="as-is"
SLOT="0"


src_unpack() {
	unpack ${A}
	cd ${S}
	zcat ${DISTDIR}/less-${PV}-iso254.patch | \
		patch -s -p1 || die "Patch failed"
}

src_compile() {
	cd ${S}

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--without-cs-regex \
		--enable-msb \
		--enable-jisx0213 \
		--with-regex=auto \
		--with-editor=/usr/bin/nano || die "Configure failed"

	emake || die "Make failed"
}

src_install() {
	make prefix=${D}/usr					\
	     binprefix=j					\
	     manprefix=j install			||	\
	     die "Install failed"
	dodoc COPYING LICENSE NEWS README README.iso README.iso.jp
	exeinto /usr/bin
	newexe ${FILESDIR}/lesspipe.sh-r1 lesspipe.sh
}
