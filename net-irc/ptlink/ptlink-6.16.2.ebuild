# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

MY_P="PTlink${PV}"
DESCRIPTION="PTlink IRCd is a secure IRC daemon with many advanced features."
HOMEPAGE="http://www.ptlink.net/"
SRC_URI="ftp://ftp.sunsite.dk/projects/ptlink/ircd/${MY_P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"

IUSE="ipv6"
DEPEND="virtual/glibc"
RDEPEND=""

S=${WORKDIR}/${MY_P}
src_compile() {
	local myconf
	econf \
		--host=${CHOST} \
		--prefix=/etc/ptlinkircd \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_enable ipv6` \
		${myconf} || die
	emake || die
}

src_install() {
	newbin src/ircd ptlinkircd || die
	newbin tools/fixklines fixklines || die
	newbin tools/mkpasswd mkpasswd || die

	insinto /etc/ptlinkircd
	doins samples/{kline.conf,opers.motd,ptlink.motd,help.admin,help.oper,help.user}
	newins samples/example.conf.short ircd.conf
	newins samples/example.conf.trillian ircd.conf.trillian
	newins samples/main.dconf.sample main.dconf
	newins samples/network.dconf.sample network.dconf

	insinto /etc/ptlinkircd/codepage
	doins src/codepage/*

	dodoc doc/* doc_hybrid6/* {CHANGES,COPYING,ChangeLog,INSTALL,LICENSE,README} ircdcron/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/ptlinkircd.rc ptlinkircd
	insinto /etc/conf.d
	newins ${FILESDIR}/ptlinkircd.confd ptlinkircd
}

pkg_postinst() {
	einfo "Ptlinkircd will run without configuration, although this is strongly advised against."
	echo
	einfo "You can find example cron scripts here:"
	einfo "   /usr/share/doc/${PF}/ircd.cron"
	echo
	einfo "You can also use /etc/init.d/ptlinkircd to start at boot"
}







