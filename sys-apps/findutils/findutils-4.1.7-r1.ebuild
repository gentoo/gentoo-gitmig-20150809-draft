# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1.7-r1.ebuild,v 1.17 2004/01/30 11:27:38 vapier Exp $

IUSE="nls build"

S=${WORKDIR}/${P}
DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://alpha.gnu.org/gnu/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
		nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--localstatedir=/var/spool/locate \
		${myconf} || die

	emake libexecdir=/usr/lib/find || die
}

src_install() {
	#do not change 'localstatedir=/var/spool/locate' to
	#'localstatedir=${D}/var/spool/locate', as it will then be hardcoded
	#into locate and updatedb
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		localstatedir=/var/spool/locate \
		libexecdir=${D}/usr/lib/find \
		install || die

	dosed "s:TMPDIR=/usr/tmp:TMPDIR=/tmp:" usr/bin/updatedb
	rm -rf ${D}/usr/var
	if [ -z "`use build`" ]
	then
		dodoc COPYING NEWS README TODO ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
	dodir /var/spool/locate
	keepdir /var/spool/locate
}

