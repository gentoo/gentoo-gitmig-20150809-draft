# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sh-utils/sh-utils-2.0.14.ebuild,v 1.1 2002/08/14 14:16:49 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Your standard GNU shell utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/shellutils/shellutils.html"

DEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# patch to remove Stallman's su/wheel group rant and to add processor
	# information in uname output
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die
	rm doc/coreutils.info
	#This next line prevents our patched (and updated-mtime) uname.c from forcing a
	#uname.1 man page regeneration, which requires perl (not available when creating
	#a new build image... and we don't want this package dependent on perl anyway.
	#This problem can be fixed by fixing our patch at a future date.
	touch -d "20 Aug 1999" src/uname.c
}

src_compile() {
	local myconf=""
	use nls || myconf="--disable-nls"
	
	CFLAGS="${CFLAGS}" \
		econf \
			--without-included-regex \
			${myconf} || die
	
	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	einstall || die
		
	rm -rf ${D}/usr/lib
	dodir /bin
	cd ${D}/usr/bin
	mv date echo false pwd stty su true uname sleep ${D}/bin

	if [ -z "`use build`" ]
	then
		cd ${S}
		dodoc AUTHORS COPYING ChangeLog ChangeLog.0 NEWS README THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
	#we must use hostname from net-base
	#hostname do not work with the -f switch ... this breaks gnome2 among things
	rm ${D}/usr/bin/hostname
	#we use the /bin/su from the sys-apps/shadow package
	rm ${D}/bin/su
	rm ${D}/usr/share/man/man1/su.1.gz
	#we use the /usr/bin/uptime from the sys-apps/procps package
	rm ${D}/usr/bin/uptime
	rm ${D}/usr/share/man/man1/uptime.1.gz
}

pkg_postinst() {
	#hostname do not get removed, as it is included with older stage1
	#tarballs, and net-tools installs to /bin
	if [ -e ${ROOT}/usr/bin/hostname ] && [ ! -L ${ROOT}/usr/bin/hostname ]
	then
		rm -f ${ROOT}/usr/bin/hostname
	fi
}

