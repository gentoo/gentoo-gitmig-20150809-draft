# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.1.30-r14.ebuild,v 1.8 2007/08/25 13:58:07 vapier Exp $

inherit eutils flag-o-matic multilib

MY_P=${P}-4_MLI.src
S=${WORKDIR}/motif
DESCRIPTION="Open Motif (Metrolink Bug Fix Release)"
HOMEPAGE="http://www.openmotif.org/"
SRC_URI="ftp://ftp.metrolink.com/pub/openmotif/2.1.30-4/${MY_P}.tar.gz
		mirror://gentoo//${P}-CAN-2004-0914-newer.patch.bz2"

LICENSE="MOTIF"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

PROVIDE="virtual/motif"

RDEPEND="virtual/libc
	x11-libs/libXmu
	x11-libs/libXaw
	x11-libs/libXp
	x11-proto/printproto
	>=x11-libs/motif-config-0.9"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	x11-misc/xbitmaps"

SLOT="2.1"

src_unpack() {
	local cfg="${S}/config/cf/site.def"

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-CAN-2004-0687-0688.patch
	epatch ${WORKDIR}/${P}-CAN-2004-0914-newer.patch
	epatch ${FILESDIR}/${P}-CAN-2004-0914_sec8.patch
	epatch ${FILESDIR}/CAN-2005-0605.patch
	epatch ${FILESDIR}/openmotif-2.2.3-uil.patch

	ebegin "adjusting file permissions"
	chmod -R ug+w .
	eend $? || die

	ebegin "setting up site.def"
	cp ${FILESDIR}/site.def ${S}/config/cf/site.def && \
	echo >>$cfg && \
	echo >>$cfg "#undef  OptimizedCDebugFlags" && \
	echo >>$cfg "#define OptimizedCDebugFlags ${CFLAGS}" && \
	echo >>$cfg "#undef  OptimizedCplusplusDebugFlags" && \
	echo >>$cfg "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}" &&\
	echo >>$cfg "#undef  LinuxCLibMajorVersion" && \
	echo >>$cfg "#define  LinuxCLibMajorVersion 6"
	eend $? || die

	# move `system.mwmrc' from `lib/X11' to `lib/X11/mwm'
	ebegin "patching 'clients/mwm/Imakefile' (mwm confdir)"
	LC_ALL="C" sed -i \
	  -e 's:\(SpecialObjectRule.*WmResParse\.o.*/lib/X11\)\(.*\):\1/mwm\2:'\
	  -e 's:\(InstallNonExecFile.system\.mwmrc,\).*/lib/X11\(.*\):\1/etc/X11/mwm\2:'\
	    "${S}/clients/mwm/Imakefile"
	eend $? || die

	epatch ${FILESDIR}/${PN}-2.1.30-imake-tmpdir.patch
	# compile on gcc 2.9x
	epatch ${FILESDIR}/${PN}-2.1.30-imake-ansi.patch
	epatch ${FILESDIR}/${PN}-2.1.30-uil-bad_grammar_fix.diff

	if use amd64 && has_multilib_profile && [[ ${ABI} == "amd64" ]] ; then
		sed -i 's:__i386__:__x86_64__:g' ${S}/config/cf/*.cf ${S}/config/imake/* ${S}/config/makedepend/*
	fi
}

src_compile() {
	# multilib includes don't work right in this package...
	has_multilib_profile && append-flags "-I/usr/include/gentoo-multilib/${ABI}"

	# glibc-2.3.2-r1/gcc-3.2.3 /w `-mcpu=athlon-xp -O2', right-clicking
	# in nedit triggers DPMS monitor standby instead of popping up the
	# context menu.  this doesn't happen on my `stable' test partition
	# where everything is compiled i686, nor with most non-essential
	# packages athlon-xp and only motif i686.  needs investigation.
	replace-flags "-mcpu=athlon-xp" "-mcpu=i686"

	# fails to copmile with -jx
	export MAKEOPTS="${MAKEOPTS} -j1"

	mkdir -p imports/x11
	cd imports/x11
	ln -s /usr/X11R6/bin bin
	ln -s /usr/X11R6/include include
	ln -s /usr/X11R6/lib lib
	cd ${S}
	make World || make World || die
}

src_install() {
	make DESTDIR=${D} VARDIR=${D}/var install || die "make install"
	make DESTDIR=${D} install.man || die "make install.man"

	# cleanups
	local NOINSTBIN="imake lndir makedepend makeg mergelib mkdirhier xmkmf"
	local NOINSTMAN1="imake lndir makedepend makeg mkdirhier xmkmf"

	rm -fR ${D}/etc
	for nib in ${NOINSTBIN}; do
		f="${D}/usr/X11R6/bin/${nib}"; rm "$f" || die "rm $f"
	done
	for nim in ${NOINSTMAN1}; do
		f="${D}/usr/X11R6/man/man1/${nim}.1x"
		rm "$f" || die "rm $f"
	done
	rm -rf "${D}/usr/X11R6/lib/X11" || die "rm config"
	rm -rf "${D}/usr/X11R6/include/X11" || die "rm config"
	rm -rf "${D}/usr/X11R6/lib/bindings" || die "rm bindings"

	dodir /usr/share/man
	mv ${D}/usr/X11R6/man/* ${D}/usr/share/man/
	dodir /usr/bin
	mv ${D}/usr/X11R6/bin/* ${D}/usr/bin/
	dodir /usr/include
	mv ${D}/usr/X11R6/include/* ${D}/usr/include/
	dodir /usr/$(get_libdir)
	mv ${D}/usr/X11R6/lib/* ${D}/usr/$(get_libdir)/
	rm -fR ${D}/usr/X11R6

	einfo "Fixing binaries"
	dodir /usr/$(get_libdir)/openmotif-2.1
	for file in `ls ${D}/usr/bin`
	do
		mv ${D}/usr/bin/${file} ${D}/usr/$(get_libdir)/openmotif-2.1/
	done

	einfo "Fixing libraries"
	mv ${D}/usr/$(get_libdir)/* ${D}/usr/$(get_libdir)/openmotif-2.1/

	einfo "Fixing includes"
	dodir /usr/include/openmotif-2.1/
	mv ${D}/usr/include/* ${D}/usr/include/openmotif-2.1

	einfo "Fixing man pages"
	mans="1 3 5 7"
	for man in $mans; do
		dodir /usr/share/man/man${man}
		for file in `ls ${D}/usr/share/man/man${man}`
		do
			file=${file/.${man}x/}
			mv ${D}/usr/share/man/man$man/${file}.${man}x ${D}/usr/share/man/man${man}/${file}-openmotif-2.1.${man}
		done
	done

	dodoc README COPYRIGHT.MOTIF RELEASE RELNOTES
	dodoc BUGREPORT OPENBUGS CLOSEDBUGS

	# profile stuff
	dodir /etc/env.d
	echo "LDPATH=/usr/lib/openmotif-2.1" > ${D}/etc/env.d/15openmotif-2.1
	dodir /usr/$(get_libdir)/motif
	echo "PROFILE=openmotif-2.1" > ${D}/usr/$(get_libdir)/motif/openmotif-2.1
}

pkg_postinst() {
	/usr/bin/motif-config -s
}

pkg_postrm() {
	/usr/bin/motif-config -s
}
