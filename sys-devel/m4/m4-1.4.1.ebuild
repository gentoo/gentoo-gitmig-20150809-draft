# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4.1.ebuild,v 1.11 2004/11/12 15:19:55 vapier Exp $

inherit eutils gnuconfig

PVER="17"
DESCRIPTION="GNU macro processor"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	ftp://ftp.seindal.dk/gnu/${P}.tar.gz"
#	mirror://gentoo/m4_1.4-${PVER}.diff.gz
#	http://ftp.debian.org/debian/pool/main/m/m4/m4_1.4-${PVER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc sh x86"
IUSE="bootstrap nls"

DEPEND="virtual/libc
	!bootstrap? ( >=sys-devel/libtool-1.3.5-r2 )
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
#	epatch ${DISTDIR}/${PN}_1.4-${PVER}.diff.gz

	gnuconfig_update
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

	dodoc BACKLOG ChangeLog NEWS README* THANKS TODO
}
