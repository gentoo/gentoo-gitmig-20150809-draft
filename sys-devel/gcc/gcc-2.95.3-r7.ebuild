# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.95.3-r7.ebuild,v 1.11 2002/08/14 03:04:37 murphy Exp $

TV=4.0
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.gz"
#	ftp://ftp.gnu.org/pub/gnu/texinfo/texinfo-${TV}.tar.gz
#	ftp://ftp.ibiblio.org/pub/linux/distributions/gentoo/distfiles/texinfo-${TV}.tar.gz"

S=${WORKDIR}/${P}
LOC=/usr
DESCRIPTION="Modern GCC C/C++ compiler and an included, upgraded version of texinfo to boot"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"
if [ -z "`use build`" ]
then
	DEPEND="${DEPEND} nls? ( sys-devel/gettext )
		>=sys-libs/ncurses-5.2-r2
		>=sys-apps/texinfo-4.2-r4"
	
	RDEPEND="${RDEPEND} >=sys-libs/ncurses-5.2-r2"
fi

#PROVIDE="sys-apps/texinfo"


src_unpack() {
	unpack ${P}.tar.gz
	
	cd ${S}

	libtoolize --copy --force &> ${T}/foo-out
	
	# This new patch for the atexit problem occured with glibc-2.2.3 should
	# work with glibc-2.2.4.  This closes bug #3987 and #4004.
	#
	# Azarah - 29 Jun 2002
	#
	# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2001/08/0476.html
	# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2001/08/0589.html
	#
	#
	# Something to note, is that this patch makes gcc crash if its given
	# the "-mno-ieee-fp" flag ... libvorbis is an good example of this.
	# This however is on of those which one we want fixed most cases :/
	#
	# Azarah - 30 Jun 2002
	#
	patch -l -p1 < ${FILESDIR}/${P}-new-atexit.diff || die
	
	# Now we integrate texinfo-${TV} into gcc.  It comes with texinfo-3.12.
#	cd ${S}
#	tar xzf ${DISTDIR}/texinfo-${TV}.tar.gz || die
#	cp -a ${S}/texinfo-4.0/* ${S}/texinfo
#	cd ${S}/texinfo
#	if [ "`use build`" ]
#	then
#		patch -p0 < ${FILESDIR}/texinfo-${TV}-no-ncurses-gentoo.diff || die
#		touch *
#	fi
}

src_compile() {
	local myconf=""
	if [ -z "`use build`" ]
	then
		myconf="${myconf} --enable-shared"
	else
		myconf="${myconf} --enable-languages=c"
	fi
	if [ -z "`use nls`" ] || [ "`use build`" ]
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	# gcc does not like optimization

	export CFLAGS="${CFLAGS/-O?/}"
	export CXXFLAGS="${CXXFLAGS/-O?/}"

	${S}/configure --prefix=${LOC} \
		--mandir=${LOC}/share/man \
		--infodir=${LOC}/share/info \
		--enable-version-specific-runtime-libs \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--enable-threads \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	if [ -z "`use static`" ]
	then
		emake bootstrap-lean || die
	else
		emake LDFLAGS=-static bootstrap || die
	fi
}

src_install() {
	make install \
		prefix=${D}${LOC} \
		mandir=${D}${LOC}/share/man \
		infodir=${D}${LOC}/share/info || die

	# binutils libiberty.a and we want to use that version
	# closes bug #2262
	rm -f ${D}/usr/lib/libiberty.a
		
	[ -e ${D}/usr/bin/gcc ] || die "gcc not found in ${D}"
	
    FULLPATH=${D}${LOC}/lib/gcc-lib/${CHOST}/${PV}
	cd ${FULLPATH}
	dodir /lib
	dosym /usr/bin/cpp /lib/cpp
	dosym gcc /usr/bin/cc
	dosym g++ /usr/bin/${CHOST}-g++
	dosym g++ /usr/bin/${CHOST}-c++
	dodir /etc/env.d
	echo "LDPATH=${LOC}/lib/gcc-lib/${CHOST}/${PV}" > \
		${D}/etc/env.d/05gcc
	
	cd ${S}
    if [ -z "`use build`" ]
    then
		#do a full texinfo-${TV} install
		
#		cd ${S}/texinfo
#	  	make DESTDIR=${D} infodir=${D}/usr/share/info install || die
#		exeinto /usr/sbin
#		doexe ${FILESDIR}/mkinfodir
#
#		cd ${D}/usr/share/info
#		mv texinfo texinfo.info
#		for i in texinfo-*
#		do
#			mv ${i} texinfo.info-${i#texinfo-*}
#		done
#
#		cd ${S}/texinfo
#	   	docinto texinfo
#		dodoc AUTHORS ChangeLog COPYING INTRODUCTION NEWS README TODO 
#		docinto texinfo/info
#		dodoc info/README
#		docinto texinfo/makeinfo
#		dodoc makeinfo/README

		# end texinfo 4.0; begin more gcc stuff

		cd ${S}
		docinto /	
		dodoc COPYING COPYING.LIB README* FAQ MAINTAINERS
		docinto html
		dodoc faq.html
		docinto gcc
		cd ${S}/gcc
		dodoc BUGS ChangeLog* COPYING* FSFChangeLog* LANGUAGES NEWS PROBLEMS README* SERVICE TESTS.FLUNK
	    cd ${S}/libchill
	    docinto libchill
	    dodoc ChangeLog
	    cd ${S}/libf2c
	    docinto libf2c
	    dodoc ChangeLog changes.netlib README TODO
	    cd ${S}/libio
	    docinto libio
	    dodoc ChangeLog NEWS README
	    cd dbz
	    docinto libio/dbz
	    dodoc README
	    cd ../stdio
	    docinto libio/stdio
	    dodoc ChangeLog*
	    cd ${S}/libobjc
	    docinto libobjc
	    dodoc ChangeLog README* THREADS*
		cd ${S}/libstdc++
		docinto libstdc++
		dodoc ChangeLog NEWS
    else
        rm -rf ${D}/usr/share/{man,info}
		# do a minimal texinfo install (build image)
#		cd ${S}/texinfo
#		dobin makeinfo/makeinfo util/{install-info,texi2dvi,texindex}
	fi
}

pkg_preinst() {
	# downgrading from gcc-3.x will leave this symlink, so
	# remove it.  resolves bug #3527
	if [ -L ${ROOT}/usr/bin/${CHOST}-g++ ] || \
	   [ -f ${ROOT}/usr/bin/${CHOST}-g++ ]
	then
		rm -f ${ROOT}/usr/bin/${CHOST}-g++
	fi
	if [ -L ${ROOT}/usr/bin/${CHOST}-c++ ] || \
	   [ -f ${ROOT}/usr/bin/${CHOST}-c++ ]
	then
		rm -f ${ROOT}/usr/bin/${CHOST}-c++
	fi
}

pkg_postrm() {
	if [ ! -L ${ROOT}/lib/cpp ]
	then
		ln -sf /usr/bin/cpp ${ROOT}/lib/cpp
	fi
	if [ ! -L ${ROOT}/usr/bin/cc ]
	then
		ln -sf gcc ${ROOT}/usr/bin/cc
	fi
}

