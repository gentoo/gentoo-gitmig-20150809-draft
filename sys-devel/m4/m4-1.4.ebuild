# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4.ebuild,v 1.6 2003/06/22 06:18:39 drobbins Exp $

IUSE="nls"

inherit eutils gnuconfig

S="${WORKDIR}/${PN}-1.4"
DESCRIPTION="GNU macro processor"
SRC_URI="ftp://ftp.seindal.dk/gnu/${PN}-1.4.tar.gz
	http://ftp.debian.org/debian/pool/main/m/m4/m4_1.4-15.diff.gz"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa arm"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	>=sys-devel/libtool-1.3.5-r2"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${DISTDIR}/${PN}_1.4-15.diff.gz

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
