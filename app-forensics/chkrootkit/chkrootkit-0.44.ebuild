# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/chkrootkit/chkrootkit-0.44.ebuild,v 1.3 2004/10/30 21:14:26 ka0ttic Exp $

inherit eutils flag-o-matic

DESCRIPTION="a tool to locally check for signs of a rootkit"
HOMEPAGE="http://www.chkrootkit.org/"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz
		 mirror://gentoo/${P}-gentoo.diff.bz2"

LICENSE="AMS"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~ia64 ~amd64 ~ppc64"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
	sed -i 's:${head} -:${head} -n :' chkrootkit || die "sed chkrootkit failed"
	sed -i 's:/var/adm:/var/log:g' chklastlog.c || die "sed chklastlog.c failed"
}

src_compile() {
	emake \
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
