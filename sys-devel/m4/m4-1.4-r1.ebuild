# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4-r1.ebuild,v 1.5 2004/01/17 14:37:36 joker Exp $

IUSE="nls"

inherit eutils gnuconfig

PVER="17"
S=${WORKDIR}/${P}
DESCRIPTION="GNU macro processor"
SRC_URI="ftp://ftp.seindal.dk/gnu/${P}.tar.gz
	mirror://gentoo/m4_1.4-${PVER}.diff.gz
	http://ftp.debian.org/debian/pool/main/m/m4/m4_1.4-${PVER}.diff.gz"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~mips hppa ~arm ia64 amd64 ppc64"

DEPEND="virtual/glibc
	!bootstrap? ( >=sys-devel/libtool-1.3.5-r2 )
	nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${DISTDIR}/${PN}_1.4-${PVER}.diff.gz

	use alpha && gnuconfig_update
}

src_compile() {
	local myconf=

	use nls || myconf="--disable-nls"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--enable-changeword \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		libexecdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

#	rm -rf ${D}/usr/include

	dodoc BACKLOG ChangeLog COPYING NEWS README* THANKS TODO
}
