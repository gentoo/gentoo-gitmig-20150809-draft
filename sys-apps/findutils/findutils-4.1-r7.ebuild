# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1-r7.ebuild,v 1.5 2002/07/14 19:20:17 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://prep.ai.mit.edu/gnu/findutils/${P}.tar.gz http://www.ibiblio.org/gentoo/distfiles/findutils-4.1.diff.gz"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"
KEYWORDS="x86"
SLOT="0"
DEPEND="virtual/glibc sys-devel/gettext"
RDEPEND="virtual/glibc"
LICENSE="GPL-2"

src_unpack() {
	unpack ${P}.tar.gz 
	echo "Applying Patch..."
	cd ${S}
	cat ${DISTDIR}/findutils-4.1.diff.gz | gzip -d | patch -p1 || die
}

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake libexecdir=/usr/lib/find || die
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info libexecdir=${D}/usr/lib/find install || die
	dosed "s:TMPDIR=/usr/tmp:TMPDIR=/tmp:" usr/bin/updatedb
	rm -rf ${D}/usr/var
	if [ -z "`use build`" ] 
	then
		dodoc COPYING NEWS README TODO ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
	dodir /var/spool/locate
	touch ${D}/var/spool/locate/.keep
}

