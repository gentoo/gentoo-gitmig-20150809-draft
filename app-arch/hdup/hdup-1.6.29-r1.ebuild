# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/hdup/hdup-1.6.29-r1.ebuild,v 1.1 2004/04/28 16:57:44 mholzer Exp $

DESCRIPTION="Hdup is backup program using tar,find,gzip/bzip2,mcrypt and ssh."
HOMEPAGE="http://www.miek.nl/projects/hdup16/hdup16.html"
SRC_URI="http://www.miek.nl/projects/hdup16/previous/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="app-arch/tar
	sys-apps/findutils
	app-arch/gzip
	app-arch/bzip2
	net-misc/openssh
	sys-apps/coreutils"

S=${WORKDIR}/${PN}16

src_unpack() {
	unpack ${A}
	cd ${S}
	# see bug 49183 for details
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodir /usr/sbin
	make prefix=${D}/usr mandir=${D}/usr/share/man sysconfdir=${D}/etc \
		install || die

	dohtml doc/FAQ.html
	dodoc ChangeLog INSTALL TODO Credits
	dodoc examples/hdup.cron examples/no-history-post-run.sh
	dodoc contrib/cleanup.pl contrib/backup.pl
}

pkg_postinst() {
	einfo "now edit your /etc/hdup/${PN}.conf"
	einfo "you can also check included examples, see:"
	einfo "\t/usr/share/doc/${P}/"
}
