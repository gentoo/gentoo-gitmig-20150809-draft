# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.20-r1.ebuild,v 1.2 2004/10/23 12:10:35 wmertens Exp $

inherit eutils

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.sunsite.dk/"
SRC_URI="http://chrony.sunsite.dk/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~mips ~sparc ~ppc"
IUSE="readline"

DEPEND="virtual/libc
	readline? ( >=sys-libs/readline-4.1-r4 )"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-conf.c-gentoo.diff
	epatch ${FILESDIR}/${P}-chrony.conf.example-gentoo.diff
	# Allow Hz=200 detection (#21058, Alexander Papaspyrou)
	epatch ${FILESDIR}/${P}-sys_linux.c-gentoo.diff
}

src_compile() {
	econf `use_enable readline` || die
	emake all docs || die
}

src_install() {
	# the chrony install is brain-dead so we'll just do it ourselves
	dobin chronyc
	dosbin chronyd

	dodoc chrony.txt README examples/chrony.{conf,keys}.example
	dohtml chrony.html
	doman *.{1,5,8}
	doinfo chrony.info*

	dodir /etc/chrony
	exeinto /etc/init.d ; newexe ${FILESDIR}/chronyd.rc chronyd
	insinto /etc/conf.d ; newins ${FILESDIR}/chronyd.conf chronyd
	dosed "s:the documentation directory:/usr/share/doc/${PF}/:" /etc/init.d/chronyd
}
