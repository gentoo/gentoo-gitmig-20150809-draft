# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bitkeeper/bitkeeper-3.0.4.ebuild,v 1.2 2004/01/31 20:45:55 vapier Exp $

DESCRIPTION="A scalable configuration management system."
HOMEPAGE="http://www.bitkeeper.com/"
SRC_URI="x86? ( bk-${PV}-x86-glibc22-linux.bin )
	ppc? ( bk-${PV}-powerpc-glibc21-linux.bin )
	sparc? ( bk-${PV}-sparc-glibc21-linux.bin )
	alpha? ( bk-${PV}-alpha-glibc22-linux.bin )
	arm? ( bk-${PV}-arm-glibc21-linux.bin )
	hppa? ( bk-${PV}-hppa-glibc22-linux.bin )
	ia64? ( bk-${PV}-ia64-glibc22-linux.bin )"

LICENSE="BKL"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha arm hppa -mips ia64"
IUSE="X"
RESTRICT="fetch"

DEPEND=""
RDEPEND="virtual/glibc
	>=dev-lang/tcl-8.3.4
	X? ( >=dev-lang/tk-8.3.4 )"

S=${WORKDIR}/bitkeeper

pkg_nofetch() {
	eerror "You need to perform the following steps to install this package:"
	eerror " - Sign up at ${HOMEPAGE}"
	eerror " - Check your email and visit the download location"
	eerror " - Download ${A} and place it in ${DISTDIR}"
	eerror " - emerge this package again"
	eerror "Run 'bk regression' to verify the installation. (Recommended)"
}

pkg_setup() {
	cd ${T}
	cp ${DISTDIR}/${A} .
	chmod 755 ${A}
	local DISPLAY=""
	echo 'none' | ./${A} > output 2>/dev/null
	installer=`sed -n -e "s/Installation script: \(.*\)/\1/p" output`
	archive=`sed -n -e "s/Gzipped tar archive: \(.*\)/\1/p" output`
	mv $archive ${T}/archive
}

src_unpack() {
	tar -vxzpf ${T}/archive
}

src_install() {
	dodir /opt /usr/share/man/man1 /usr/bin

	mv ${S} ${D}/opt/${P} && cd ${D}

	# BK includes two copies of most man pages; the second copy is a
	# hard link to the first with its filename prefixed with
	# 'bk-'. 'prepman' breaks these hard links, so use a
	# workaround. Furthermore, we want only the 'bk-' versions to be
	# in ${MANPATH} since there are naming conflicts, so install
	# symlinks into /usr/share/man. (For example BK includes a
	# less-detailed man page for grep which would override the
	# /usr/share/man version.)

	prepman /opt/${P}

	find opt/${P}/man -iname 'bk-*' -printf '
		F=`echo %f|sed -e "s/bk-//"`
		rm -f %h/$F
		dohard /%h/%f /%h/$F
		dosym /%h/%f /usr/share/man/%P' >${T}/links.sh
	. ${T}/links.sh

	dosym /opt/${P}/man/man1/bk.1.gz /usr/share/man/man1/bk.1.gz

	# mimic "bk links /opt/${P} /usr/bin"
	dosym /opt/${P}/admin /usr/bin/admin
	dosym /opt/${P}/bk /usr/bin/bk
	dosym /opt/${P}/delta /usr/bin/delta
	dosym /opt/${P}/get /usr/bin/get
	dosym /opt/${P}/prs /usr/bin/prs
	dosym /opt/${P}/rmdel /usr/bin/rmdel
	dosym /opt/${P}/unget /usr/bin/unget
}

pkg_postinst() {
	if grep -H bitkeeper /etc/man.conf; then
		eerror "Previous BitKeeper ebuilds induced a misconfiguration when sys-apps/man was"
		eerror "next upgraded. You appear to have fallen victim--edit /etc/man.conf and look"
		eerror "for the definition of CMP. It should refer to /usr/bin/cmp, not the"
		eerror "BitKeeper cmp."
		eerror "For more information, see bugs #18247 and #21638."
	fi
}
