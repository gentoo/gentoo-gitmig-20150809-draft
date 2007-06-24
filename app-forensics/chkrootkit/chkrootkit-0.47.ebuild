# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/chkrootkit/chkrootkit-0.47.ebuild,v 1.9 2007/06/24 21:15:11 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="a tool to locally check for signs of a rootkit"
HOMEPAGE="http://www.chkrootkit.org/"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz
	mirror://gentoo/${PN}-0.45-gentoo.diff.bz2"

LICENSE="AMS"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# we can use the gentoo patch for 0.45 but it needs one change to apply
	# cleanly -- certainly not enough to warrant using a separate 32k patch.
	sed -e 's|\(xlogin\)|\^\1|' "${WORKDIR}"/${PN}-0.45-gentoo.diff > \
		"${WORKDIR}"/${P}-gentoo.diff

	epatch \
		"${WORKDIR}"/${P}-gentoo.diff \
		"${FILESDIR}"/${P}-makefile.diff \
		"${FILESDIR}"/${P}-add-missing-includes.diff

	sed -i 's:${head} -:${head} -n :' chkrootkit || die "sed chkrootkit failed"
	sed -i 's:/var/adm:/var/log:g' chklastlog.c || die "sed chklastlog.c failed"
}

src_compile() {
	emake CC=$(tc-getCC) sense || die "emake sense failed"
}

src_install() {
	dosbin chkdirs chklastlog chkproc chkrootkit chkwtmp chkutmp ifpromisc \
		strings-static || die
	dodoc ACKNOWLEDGMENTS README*

	exeinto /etc/cron.weekly
	newexe "${FILESDIR}"/${PN}.cron ${PN} || die
}

pkg_postinst() {
	echo
	elog "Edit /etc/cron.weekly/chkrootkit to activate chkrootkit!"
	elog
	elog "Some applications, such as portsentry, will cause chkrootkit"
	elog "to produce false positives.  Read the chkrootkit FAQ at"
	elog "http://www.chkrootkit.org/ for more information."
	echo
}
