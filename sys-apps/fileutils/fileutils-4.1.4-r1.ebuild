# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.1.4-r1.ebuild,v 1.1 2002/01/11 23:36:58 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}/src
	#patch dircolors to work for zsh (this comes from slackware's package)
	rm -rf ${S}/src/dircolors.c
	zcat ${FILESDIR}/fileutils.dircolors.diff.gz \
		| patch || die
}

src_compile() {
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--bindir=/bin \
		${myconf} || die
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

		#update the dircolors manpage
		rm -f ${D}/usr/share/man/man1/dircolors*
		cp ${FILESDIR}/dircolors.1.gz ${D}/usr/share/man/man1/dircolors.1.gz
	else
		rm -rf ${D}/usr/share
	fi

	insinto /etc
	doins ${FILESDIR}/DIR_COLORS
}

