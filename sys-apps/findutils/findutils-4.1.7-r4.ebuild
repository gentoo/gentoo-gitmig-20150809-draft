# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1.7-r4.ebuild,v 1.1 2003/04/11 21:34:25 agriffis Exp $

IUSE="nls build afs selinux"

inherit eutils

S=${WORKDIR}/${P}

DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://alpha.gnu.org/gnu/${P}.tar.gz
	selinux? mirror://gentoo/${P}-2003011510-selinux-gentoo.patch.bz2"

HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"

KEYWORDS="~x86 ~hppa ~arm ~alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sed-4
	nls? ( sys-devel/gettext )
	afs? ( net-fs/openafs )
	selinux? ( sys-apps/selinux-small )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Don't build or install locate because it conflicts with slocate,
	# which is a secure version of locate.  See bug 18729
	sed -i '/^SUBDIRS/s/locate//' Makefile.in

	use selinux && epatch ${DISTDIR}/${P}-2003011510-selinux-gentoo.patch.bz2
}

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	if use afs; then
		export CPPFLAGS=-I/usr/afsws/include
		export LDFLAGS=-lpam
		export LIBS=/usr/afsws/lib/pam_afs.so.1
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		${myconf} || die

	emake libexecdir=/usr/lib/find || die
}

src_install() {
	einstall libexecdir=${D}/usr/lib/find || die
		
	prepallman

	rm -rf ${D}/usr/var
	if ! use build; then
		dodoc COPYING NEWS README TODO ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
}
