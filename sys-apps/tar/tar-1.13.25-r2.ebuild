# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tar/tar-1.13.25-r2.ebuild,v 1.4 2002/07/16 05:51:08 seemant Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Use this to try make tarballs :)"
SRC_URI="ftp://alpha.gnu.org/gnu/tar/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/tar/"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc nls? ( >=sys-devel/gettext-0.10.35 )"

RDEPEND="virtual/glibc"

src_compile() {
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --prefix=/usr --bindir=/bin --libexecdir=/usr/lib/misc \
	--infodir=/usr/share/info --host=${CHOST} ${myconf} || die
	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	#FHS 2.1 stuff
	dodir /usr/sbin
	cd ${D}
	mv usr/lib/misc/rmt usr/sbin/rmt.gnu
	dosym rmt.gnu /usr/sbin/rmt
	# a nasty yet required symlink: 
	dodir /etc 
	dosym /usr/sbin/rmt /etc/rmt 
	cd ${S}
	if [ -z "`use build`" ] 
	then
		dodoc AUTHORS ChangeLog* COPYING NEWS README* PORTS THANKS
		doman ${FILESDIR}/tar.1
	else
		rm -rf ${D}/usr/share
	fi
}
