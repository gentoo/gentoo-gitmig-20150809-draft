# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.1.30-r5.ebuild,v 1.17 2004/10/27 16:24:09 vapier Exp $

inherit eutils flag-o-matic

MY_P=${P}-4_MLI.src
S=${WORKDIR}/motif
DESCRIPTION="Open Motif (Metrolink Bug Fix Release)"
HOMEPAGE="http://www.metrolink.com/openmotif/"
SRC_URI="ftp://ftp.metrolink.com/pub/openmotif/2.1.30-4/${MY_P}.tar.gz"

LICENSE="MOTIF"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ppc-macos sparc x86"
IUSE=""

DEPEND="virtual/libc
	virtual/x11
	>=sys-apps/sed-4"

src_unpack() {
	local cfg="${S}/config/cf/site.def"

	unpack ${A}
	cd ${S}
	ebegin "adjusting file permissions"
	chmod -R ug+w .
	eend $? || die

	ebegin "setting up site.def"
	cp ${FILESDIR}/site.def.1 ${S}/config/cf/site.def && \
	echo >>$cfg && \
	echo >>$cfg "#undef  OptimizedCDebugFlags" && \
	echo >>$cfg "#define OptimizedCDebugFlags ${CFLAGS}" && \
	echo >>$cfg "#undef  OptimizedCplusplusDebugFlags" && \
	echo >>$cfg "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}" &&\
	echo >>$cfg "#undef  LinuxCLibMajorVersion" && \
	echo >>$cfg "#define  LinuxCLibMajorVersion 6"
	eend $? || die

	sed -i -e "s:#define USE_BYACC               YES:#undef USE_BYACC:" config/cf/host.def

	# move `system.mwmrc' from `lib/X11' to `lib/X11/mwm' (but install into
	# `/etc/X11/mwm')
	ebegin "patching 'clients/mwm/Imakefile' (mwm confdir)"
	LC_ALL="C" sed -i \
	  -e 's:\(SpecialObjectRule.*WmResParse\.o.*/lib/X11\)\(.*\):\1/mwm\2:'\
	  -e 's:\(InstallNonExecFile.system\.mwmrc,\).*/lib/X11\(.*\):\1/etc/X11/mwm\2:'\
	    "${S}/clients/mwm/Imakefile"
	eend $? || die
	#

	epatch ${FILESDIR}/${P}-imake-tmpdir.patch
	# compile on gcc 2.9x
	epatch ${FILESDIR}/${P}-imake-ansi.patch
	epatch ${FILESDIR}/${P}-uil-bad_grammar_fix.diff
	use ppc-macos && epatch ${FILESDIR}/${P}-darwin-netbsd.diff
}

src_compile() {
	# glibc-2.3.2-r1/gcc-3.2.3 /w `-mcpu=athlon-xp -O2', right-clicking
	# in nedit triggers DPMS monitor standby instead of popping up the 
	# context menu.  this doesn't happen on my `stable' test partition 
	# where everything is compiled i686, nor with most non-essential 
	# packages athlon-xp and only motif i686.  needs investigation.
	replace-flags "-mcpu=athlon-xp" "-mcpu=i686"

	mkdir -p imports/x11
	cd imports/x11
	ln -s /usr/X11R6/bin bin
	ln -s /usr/X11R6/include include
	ln -s /usr/X11R6/lib lib
	cd ${S}
	make World || make World || die
}

src_install() {
	make DESTDIR=${D} VARDIR=${D}/var/X11/ install || die "make install"
	make DESTDIR=${D} install.man || die "make install.man"

	# these overlap with X11
	local NOINSTBIN="imake lndir makedepend makeg mergelib mkdirhier xmkmf"
	local NOINSTMAN1="imake lndir makedepend makeg mkdirhier xmkmf"

	einfo "Cleaning up X11 stuff"
	rm -fR ${D}/etc
	for nib in ${NOINSTBIN}; do
		f="${D}usr/X11R6/bin/${nib}"; rm "$f" || die "rm $f"
	done
	for nim in ${NOINSTMAN1}; do
		if useq ppc-macos || useq macos ; then
			f="${D}usr/X11R6/man/man1/${nim}.1"
		else
			f="${D}usr/X11R6/man/man1/${nim}.1x"
		fi
		 rm "$f" || die "rm $f"
	done
	rm -rf "${D}usr/X11R6/lib/X11" || die "rm config"
	rm -rf "${D}usr/X11R6/lib/bindings" || die "rm bindings"

	einfo "Fixing docs"
	dodoc README COPYRIGHT.MOTIF RELEASE RELNOTES
	dodoc BUGREPORT OPENBUGS CLOSEDBUGS
}

pkg_postinst() {
	ewarn "This might break applications linked against libXm.so.3"
	ewarn "Just rebuild these applications."
}
