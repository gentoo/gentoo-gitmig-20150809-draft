# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sharutils/sharutils-4.2.1-r5.ebuild,v 1.5 2002/08/14 03:32:54 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools to deal with shar archives"
SRC_URI="ftp://prep.ai.mit.edu/gnu/sharutils/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/sharutils/"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc sys-apps/texinfo
		nls? ( >=sys-devel/gettext-0.10.35 )"
RDEPEND="virtual/glibc"


src_unpack() {

	 unpack ${A}
	 cd ${WORKDIR}
	 patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
	 cd ${S}/po
	 mv nl.po nl.po.orig
	 sed -e 's/aangemaakt/aangemaakt\\n/' nl.po.orig > nl.po
	 mv pt.po pt.po.orig
	 sed -e 's/de %dk/de %dk\\n/' pt.po.orig > pt.po

}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	./configure --host=${CHOST} --prefix=/usr ${myconf} || die
	make ${MAKEOPTS} localedir=/usr/share/locale || die
}

src_install() {

	make \
		prefix=${D}/usr \
		localedir=${D}/usr/share/locale \
		infodir=${D}/usr/share/info \
		install || die

	doman doc/*.[15]
	#Remove some strange locals
	cd ${D}/usr/share/locale
	for i in *.
	do
	   rm -rf ${i}
	done
	rm -rf ${D}/usr/lib

	cd ${S}
	dodoc AUTHORS BACKLOG COPYING ChangeLog ChangeLog.OLD \
		NEWS README README.OLD THANKS TODO
}


