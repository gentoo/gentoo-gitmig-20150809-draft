# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/csh/csh-1.29.ebuild,v 1.2 2003/05/29 14:09:47 taviso Exp $

DESCRIPTION="Classic UNIX shell with C like syntax"
HOMEPAGE="http://www.netbsd.org/"

SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-release-1-6/src/usr.bin/printf/printf.c
	ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-release-1-6/src/include/vis.h
	ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-release-1-6/src/lib/libc/gen/vis.c"

RESTRICT="nomirror"

# theres basically a choice of fetching the individual files via 
# ftp, and using nomirror to stop spamming the mirrors, or fetch 
# a tarball of the whole lot and waste bandwidth.
# 
# the other option is to check it out of cvs, using tags to make 
# sure we get a consistent version. 
# 
# i decided to go with cvs.

inherit cvs flag-o-matic eutils ccc

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE="static doc"

DEPEND="virtual/glibc
	sys-devel/pmake
	>=sys-apps/sed-4
	doc? ( sys-apps/groff )"
RDEPEND="virtual/glibc"

ECVS_SERVER="anoncvs.netbsd.org:/cvsroot"
ECVS_MODULE="src/bin/csh"
ECVS_USER="anoncvs"
ECVS_PASS="anoncvs"
ECVS_BRANCH="netbsd-1-6"

S="${WORKDIR}/${ECVS_MODULE}"

src_compile() {
	# hide some BSDisms, mostly my work, got some hints from the
	# debian project (they use an older OpenBSD csh, though).
	cd ${S}; epatch ${FILESDIR}/linux-vs-bsd.diff || die "patching failed."

	# copy some required files over, two from NetBSD
	# and one provided with the bash shell.

	# The file `mksignames.c` and the product of its execution
	# is the only reason this ebuild is dual license, without
	# this code (eg make your own array) this shell will be 
	# 100% BSD. i borrowed it from bash-2.05b, btw.

	cd ${S}; cp ${DISTDIR}/printf.c \
				${DISTDIR}/vis.h \
				${FILESDIR}/mksignames.c \
				${DISTDIR}/vis.c \
				${S} 
	# this utility spits out an array of signal names.

	einfo "Making a list of signal names..."
	${CC:-gcc} ${CFLAGS} ${LDFLAGS} -o ${T}/mksignames ${S}/mksignames.c
	${T}/mksignames > ${S}/signames.h || die "couldnt get a list of signals."

	einfo "Adding flags required for succesful compilation..."
	# this should be easier than maintaining a patch. 
	for i in {-Dlint,-w,-D__dead="",-D__LIBC12_SOURCE__,-DNODEV="-1",-DTTYHOG=1024,-DMAXPATHLEN=4096,-D_GNU_SOURCE,-D_DIAGASSERT="assert"}
	do
		append-flags ${i}
	done

	einfo "Making some final tweaks..."
	sed -i 's#sys/tty.h#linux/tty.h#g' ${S}/file.c
	sed -i 's!\(#include "proc.h"\)!\1\n#include "signames.h"\n!g' ${S}/proc.c
	sed -i 's#\(strpct.c time.c\)#\1 vis.c#g' ${S}/Makefile
	sed -i 's!#include "namespace.h"!!g' ${S}/vis.c

	# maybe they dont warn on BSD, but _damn_.
	export NOGCCERROR=1
	
	# if csh is a users preferred shell, they may want
	# a static binary to help on the event of fs emergency.
	use static && append-ldflags -static
	
	# pmake is a portage binary as well, so specify full path.
	# if yours isnt in /usr/bin, you can set PMAKE_PATH.
	einfo "Starting build..."
	${PMAKE_PATH:-/usr/bin/}pmake || die "compile failed."

	# make the c shell guide
	use doc && {
		einfo "Making documentation..."
		cd ${S}/USD.doc
		${PMAKE_PATH:-/usr/bin/}pmake
	}
	cd ${S}
}

src_install() {
	exeinto /bin
	doexe csh
	doman csh.1
	dodoc USD.doc/paper.ps
}

pkg_postinst() {
	use doc >/dev/null && {
		einfo "An Introduction to the C shell by William Joy, a "
		einfo "postscript document included with this shell has"
		einfo "been installed in /usr/share/docs/${P}, if you are new"
		einfo "to the C shell, you may find it interesting."
	} || {
		einfo "You didnt have the \`doc\` use flag set, the"
		einfo "postscript document \"An Introduction to the C"
		einfo "shell by William Joy\" was not installed."
	}
}
