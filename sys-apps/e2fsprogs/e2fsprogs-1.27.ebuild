# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/e2fsprogs/e2fsprogs-1.27.ebuild,v 1.10 2002/09/14 15:51:24 bjb Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard EXT2 and EXT3 filesystem utilities"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="GPL-2"

#debianutils is for 'readlink'
DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	sys-apps/debianutils
	sys-apps/texinfo"
	
RDEPEND="virtual/glibc"

src_compile() {
	local myconf
	if [ "`use nls`" ]
	then
		myconf="--enable-nls"
	else
		myconf="--disable-nls"
	fi
	
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--enable-dynamic-e2fsck \
		--enable-elf-shlibs \
		${myconf} || die
		
	# Parallel make sometimes fails
	make || die
}

src_install() {
	make DESTDIR=${D} libdir=zapme install || die
	#evil e2fsprogs makefile -- I'll get you!
	rm -rf ${D}/zapme
	
	make DESTDIR=${D} install-libs || die
	
	if [ "`use nls`" ]
	then
		( cd po; make DESTDIR=${D} install || die )
	fi
	
	dodoc COPYING ChangeLog README RELEASE-NOTES SHLIBS
	docinto e2fsck
	dodoc e2fsck/ChangeLog e2fsck/CHANGES
	
	dodir /lib /bin /sbin
	cd ${D}/usr/lib
	mv * ../../lib
	cd ${D}/lib
	mv *.a ../usr/lib
	local mylib
	local x
	#normalize evil symlinks
	cd ${D}/lib
	for x in *
	do
		[ ! -L $x ]&& continue
		mylib=`readlink $x`
		mylib=`basename $mylib`
		ln -sf $mylib $x
	done
	mv ${D}/usr/bin/* ${D}/bin
	mv ${D}/usr/sbin/* ${D}/sbin
	cd ${D}/usr/bin
	mv lsattr chattr uuidgen ../usr/bin
	cd ${D}/sbin
	mv mklost+found ../usr/sbin
	#time to convert hard links/duplicates to symbolic links
	cd ${D}/sbin
	rm fsck.*
	ln -sf e2fsck fsck.ext2
	ln -sf e2fsck fsck.ext3
	rm mkfs.*
	ln -sf mke2fs mkfs.ext2

	# 03 Aug 2002 <raker@gentoo.org>
        # There are awk files that don't get installed when doing
        # a 'make install'.  They are the template files for
        # /bin/compile_et.

        cd ${S}/lib/et
        insinto /usr/share/et
        doins et_c.awk et_h.awk
        cd ${S}/lib/ss
        insinto /usr/share/ss
        doins ct_c.awk
}

