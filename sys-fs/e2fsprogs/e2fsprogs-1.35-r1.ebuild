# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/e2fsprogs/e2fsprogs-1.35-r1.ebuild,v 1.14 2004/12/08 02:19:15 vapier Exp $

inherit eutils flag-o-matic gnuconfig toolchain-funcs

DESCRIPTION="Standard EXT2 and EXT3 filesystem utilities"
HOMEPAGE="http://e2fsprogs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nls static diet"

RDEPEND="!diet? ( virtual/libc )
	diet? ( dev-libs/dietlibc )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	# Fix a cosmetic error in mk_cmds's help output.
	cd ${S}; epatch ${FILESDIR}/e2fsprogs-1.32-mk_cmds-cosmetic.patch
	# Userpriv fix. Closes #27348
	chmod u+w po/*.po
	# Patch to make the configure and sed scripts more friendly to, 
	# for example, the Estonian locale
	epatch ${FILESDIR}/${PN}-sed-locale.patch

	gnuconfig_update

	# Use -fPIC compiled shared files in .a files. Fix kdelibs-3.3.0 compilation on hppa.
	use static || sed -e '/ARUPD/s:$(OBJS):elfshared/*.o:' -i ${S}/lib/Makefile.library

	# kernel headers use the same defines as e2fsprogs and can cause issues #48829
	sed -i \
		-e 's:CONFIG_JBD_DEBUG:__CONFIG_JBD_DEBUG__E2FS:g' \
		configure e2fsck/journal.c e2fsck/recovery.c \
		e2fsck/unix.c lib/ext2fs/kernel-jbd.h \
		|| die "sed jbd debug failed"
}

src_compile() {
	# building e2fsprogs on sparc results in silo breaking
	[ "${ARCH}" = "sparc" ] && filter-flags -fstack-protector

	export LDCONFIG=/bin/true
	export CC=$(tc-getCC)
	export STRIP=/bin/true

	local myconf
	use static \
		&& myconf="${myconf} --with-ldopts=-static" \
		|| myconf="${myconf} --enable-dynamic-e2fsck --enable-elf-shlibs"
	use diet && myconf="${myconf} --with-diet-libc"
	econf \
		$(use_enable nls) \
		${myconf} || die

	# Parallel make sometimes fails
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} libdir=/zapme install || die
	#evil e2fsprogs makefile -- I'll get you!
	rm -rf ${D}/zapme

	make DESTDIR=${D} install-libs || die

	dodoc ChangeLog README RELEASE-NOTES SHLIBS
	docinto e2fsck
	dodoc e2fsck/ChangeLog e2fsck/CHANGES

	dodir /$(get_libdir) /bin /sbin
	cd ${D}/usr/$(get_libdir)
	mv * ../../$(get_libdir)
	cd ${D}/$(get_libdir)
	mv *.a ../usr/$(get_libdir)
	local mylib=""
	local x=""
	#install ldscripts to fix bug #4411
	cd ${D}/usr/$(get_libdir)
	for x in *.a
	do
		[ ! -f ${x} ] && continue
		gen_usr_ldscript ${x/a}so
	done
	#normalize evil symlinks
	cd ${D}/$(get_libdir)
	for x in *
	do
		[ ! -L ${x} ] && continue
		mylib="`readlink ${x}`"
		mylib="`basename ${mylib}`"
		ln -sf ${mylib} ${x}
	done

	mv ${D}/usr/sbin/* ${D}/sbin
	cd ${D}/usr/bin
	mv lsattr chattr uuidgen ../../bin
	cd ${D}/sbin
	mv mklost+found ../usr/sbin
	#time to convert hard links/duplicates to symbolic links
	cd ${D}/sbin
	rm fsck.*
	ln -sf e2fsck fsck.ext2
	ln -sf e2fsck fsck.ext3
	rm mkfs.*
	ln -sf mke2fs mkfs.ext2
	ln -sf mke2fs mkfs.ext3

	# 03 Aug 2002 <raker@gentoo.org>
	# There are awk files that don't get installed when doing
	# a 'make install'.  They are the template files for
	# /bin/compile_et.
	cd ${S}/$(get_libdir)/et
	insinto /usr/share/et
	doins et_c.awk et_h.awk
	cd ${S}/$(get_libdir)/ss
	insinto /usr/share/ss
	doins ct_c.awk
}
