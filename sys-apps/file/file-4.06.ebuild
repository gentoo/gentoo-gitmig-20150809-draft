# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.06.ebuild,v 1.1 2003/10/16 20:40:43 mholzer Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~arm ~alpha ~hppa ~mips ~ia64"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# (12 Oct 2003) <kumba@gentoo.org>
	# This sed command fixes file's src/patchlevel.h to report the proper version
	# information.  Current, file-4.05 reports itself as file-4.04.  An email is
	# Going to be sent to the author about this, so this little kludge will not
	# be needed with the next version of file.
	mv -f ${S}/src/patchlevel.h ${S}/src/patchlevel.h.orig
	sed -re 's/(#define\W+)(patchlevel\W+)4/\1\25/g' ${S}/src/patchlevel.h.orig > ${S}/src/patchlevel.h

	# (12 Oct 2003) <kumba@gentoo.org>
	# This patch is for MIPS only.  It slightly changes the 'file' output
	# on MIPS machines to a specific format so that other programs can 
	# recognize things.
	if [ "${ARCH}" = "mips" ]; then
		epatch ${FILESDIR}/${P}-mips-gentoo.diff
	fi
}

src_compile() {

	# file command segfaults on hppa -  reported by gustavo@zacarias.com.ar
	[ ${ARCH} = "hppa" ] && filter-flags "-mschedule=8000"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share/misc \
		--host=${CHOST} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	if [ -z "`use build`" ] ; then
		dodoc ChangeLog LEGAL.NOTICE MAINT README || die
	else
		rm -rf ${D}/usr/share/man
	fi
}
