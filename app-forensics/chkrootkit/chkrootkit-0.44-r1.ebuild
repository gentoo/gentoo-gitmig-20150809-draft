# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/chkrootkit/chkrootkit-0.44-r1.ebuild,v 1.3 2005/08/06 16:15:17 ka0ttic Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="a tool to locally check for signs of a rootkit"
HOMEPAGE="http://www.chkrootkit.org/"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

LICENSE="AMS"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff || die "patch failed"
	sed -i 's:${head} -:${head} -n :' chkrootkit || die "sed chkrootkit failed"
	sed -i 's:/var/adm:/var/log:g' chklastlog.c || die "sed chklastlog.c failed"
	epatch ${FILESDIR}/${P}-coreutils-static-falsepositive.patch || die "patch failed"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		sense || die "emake sense failed"
}

src_install() {
	dosbin chkdirs chklastlog chkproc chkrootkit chkwtmp ifpromisc \
		strings-static || die
	dodoc README README.chklastlog README.chkwtmp

	exeinto /etc/cron.weekly
	newexe ${FILESDIR}/${PN}.cron ${PN} || die
}

pkg_postinst() {
	echo
	einfo "Edit /etc/cron.weekly/chkrootkit to activate chkrootkit!"
	einfo
	einfo "Some applications, such as portsentry, will cause chkrootkit"
	einfo "to produce false positives.  Read the chkrootkit FAQ at"
	einfo "http://www.chkrootkit.org/ for more information."
	echo
}
