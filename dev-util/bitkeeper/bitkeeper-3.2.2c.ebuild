# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bitkeeper/bitkeeper-3.2.2c.ebuild,v 1.2 2004/07/18 21:55:08 aliz Exp $

DESCRIPTION="A scalable configuration management system"
HOMEPAGE="http://www.bitkeeper.com/"
SRC_URI="alpha? ( bk-${PV}-alpha-glibc22-linux.bin )
	arm? ( bk-${PV}-arm-glibc21-linux.bin )
	hppa? ( bk-${PV}-hppa-glibc22-linux.bin )
	ia64? ( bk-${PV}-ia64-glibc22-linux.bin )
	mips? ( bk-${PV}-mips-glibc22-linux.bin )
	ppc? ( bk-${PV}-powerpc-glibc21-linux.bin )
	s390? ( bk-${PV}-s390-glibc22-linux.bin )
	sparc? ( bk-${PV}-sparc-glibc21-linux.bin )
	x86? ( bk-${PV}-x86-glibc23-linux.bin )
	amd64? ( bk-${PV}-x86_64-glibc23-linux.bin )"

LICENSE="BKL"
SLOT="0"
KEYWORDS="alpha arm hppa ia64 mips ppc s390 sparc x86 ~amd64"
IUSE="X"
RESTRICT="fetch"

DEPEND=""
RDEPEND="virtual/libc
	>=dev-lang/tcl-8.3.4
	X? ( >=dev-lang/tk-8.3.4 )"

S=${WORKDIR}

pkg_nofetch() {
	einfo "You need to perform the following steps to install this package:"
	einfo " - Sign up at ${HOMEPAGE}"
	einfo " - Check your email and visit the download location"
	einfo " - Download ${A} and place it in ${DISTDIR}"
	einfo " - emerge this package again"
	einfo "Run 'bk regression' to verify the installation. (Recommended)"
}

src_unpack() {
	return
}

src_install() {
	dodir /opt /usr/share/man/man1 /usr/bin
	cd ${T}
	cp ${DISTDIR}/${A} .
	chmod 755 ${A}
	BK_NOLINKS='y' ./${A} ${D}/opt/${P}
	cd ${D}

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
	if grep -H bitkeeper ${ROOT}/etc/man.conf; then
		eerror "Previous BitKeeper ebuilds induced a misconfiguration when sys-apps/man was"
		eerror "next upgraded. You appear to have fallen victim--edit /etc/man.conf and look"
		eerror "for the definition of CMP. It should refer to /usr/bin/cmp, not the"
		eerror "BitKeeper cmp."
		eerror "For more information, see bugs #18247 and #21638."
	fi
}
