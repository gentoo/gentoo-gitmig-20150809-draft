# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.1.8-r2.ebuild,v 1.12 2003/06/21 21:19:39 drobbins Exp $

IUSE="nls build acl"

ACLPV=4.1.8acl-0.8.25

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${P}.tar.gz http://acl.bestbits.at/current/diff/fileutils-${ACLPV}.xdelta"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"
KEYWORDS="x86  ppc sparc alpha mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
		nls? ( sys-devel/gettext )
		acl? ( dev-util/xdelta )"
RDEPEND="virtual/glibc
		acl? ( sys-apps/acl )"

src_unpack() {
	if [ "`use acl`" ]; then
		cp ${DISTDIR}/${P}.tar.gz ${WORKDIR}/.
		xdelta patch ${DISTDIR}/fileutils-${ACLPV}.xdelta ${WORKDIR}/${P}.tar.gz || die
		tar xz --no-same-owner -f ${WORKDIR}/${P}acl.tar.gz || die 
		mv ${WORKDIR}/${P}acl ${WORKDIR}/${P}

		# fix NLS include buglet
		cd ${S}/lib
		cat ${FILESDIR}/acl.c.diff | patch -p0 -l || die

		cd ${S}
	else
		unpack ${P}.tar.gz ; cd ${S}
	fi
}

src_compile() {
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--bindir=/bin \
		${myconf} || die
	#fix NULL undefined compilation problem when nls not in USE (and no libintl.h is #included)
	echo "#include <stddef.h>" >> config.in
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		bindir=${D}/bin \
		install || die
	cd ${D}
	dodir /usr/bin
	rm -rf usr/lib
	cd usr/bin
	ln -s ../../bin/* .
	if [ -z "`use build`" ]
	then
		cd ${S}
		dodoc COPYING NEWS README*  THANKS TODO ChangeLog ChangeLog-1997 AUTHORS

		#conflicts with textutils.  seems that they install the same
		#.info file between the two of them
		rm -f ${D}/usr/share/info/coreutils.info
	else
		rm -rf ${D}/usr/share
	fi
}

