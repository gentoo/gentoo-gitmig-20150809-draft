# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/csh/csh-1.29-r1.ebuild,v 1.1 2003/06/12 20:34:31 taviso Exp $

DESCRIPTION="Classic UNIX shell with C like syntax"
HOMEPAGE="http://www.netbsd.org/"

SRC_URI="http://cvs.gentoo.org/~taviso/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE="static doc"

DEPEND="virtual/glibc
	sys-devel/pmake
	>=sys-apps/sed-4
	doc? ( sys-apps/groff )
	sys-apps/util-linux"
RDEPEND="virtual/glibc"

inherit flag-o-matic eutils ccc

S="${WORKDIR}/src/bin/csh"

src_compile() {
	# hide some BSDisms, mostly my work, got some hints from the
	# debian project (they use an older OpenBSD csh, though).
	cd ${S}; epatch ${FILESDIR}/linux-vs-bsd.diff || die "patching failed."

	# copy some required files over, from NetBSD

	cd ${S}; cp ${WORKDIR}/printf.c \
				${WORKDIR}/vis.h \
				${WORKDIR}/vis.c \
				${S} 
				
	# this parses the output of the bash builtin `kill`
	# and creates an array of signal names for csh.

	einfo "Making a list of signal names..."

	local cnt=0

	printf "/* automatically generated during %s build */\n\n" ${P} > ${S}/signames.h
	printf "const char *const sys_signame[NSIG + 3] = {\n" >> ${S}/signames.h
	printf "\t\"EXIT\",\t\n" $((cnt++)) >> ${S}/signames.h
	
	for i in `kill -l`
	do
		let $((cnt++))%2 && continue
		einfo "	Adding ${i}..."
		printf "\t\"%s\",\n" ${i} >> ${S}/signames.h
	done
	
	printf "\t\"DEBUG\",\n\t\"ERR\",\n\t(char *)0x0\n};\n\n" >> ${S}/signames.h

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
	
	echo
	size csh 
	echo
	
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
	use doc && dodoc USD.doc/paper.ps
}

pkg_postinst() {
	echo
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
	echo
}
