# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ptlink-ircd/ptlink-ircd-6.18.2.ebuild,v 1.1 2004/10/18 16:08:02 swegener Exp $

inherit eutils

MY_P="PTlink${PV}"

DESCRIPTION="PTlink IRCd is a secure IRC daemon with many advanced features."
HOMEPAGE="http://www.ptlink.net/"
SRC_URI="ftp://ftp.sunsite.dk/projects/ptlink/ircd/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

IUSE="ipv6"
DEPEND="sys-libs/zlib"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	find ${S} -type d -name CVS -exec rm -rf {} \; 2>/dev/null
}

src_compile() {
	econf \
		`use_enable ipv6` \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newbin src/ircd ptlink-ircd
	newbin tools/fixklines ptlink-ircd-fixklines
	newbin tools/mkpasswd ptlink-ircd-mkpasswd

	insinto /etc/ptlink-ircd
	fperms 700 /etc/ptlink-ircd
	doins samples/{kline.conf,{opers,ptlink}.motd,help.{admin,oper,user}}
	newins samples/example.conf.short ircd.conf
	newins samples/example.conf.trillian ircd.conf.trillian
	newins samples/main.dconf.sample main.dconf
	newins samples/network.dconf.sample network.dconf

	insinto /etc/ptlink-ircd/codepage
	doins src/codepage/*.enc

	rm -rf doc/old
	dodoc doc/* doc_hybrid6/* ircdcron/* CHANGES README

	keepdir /var/log/ptlink-ircd /var/lib/ptlink-ircd
	dosym /var/log/ptlink-ircd /var/lib/ptlink-ircd/log

	exeinto /etc/init.d
	newexe ${FILESDIR}/ptlink-ircd.init.d ptlink-ircd
	insinto /etc/conf.d
	newins ${FILESDIR}/ptlink-ircd.conf.d ptlink-ircd
}

pkg_postinst() {
	enewuser ptlink-ircd

	chown ptlink-ircd \
		${ROOT}/{etc,var/{log,lib}}/ptlink-ircd

	einfo
	einfo "PTlink IRCd will run without configuration, although this is strongly"
	einfo "advised against."
	einfo
	einfo "You can find example cron scripts here:"
	einfo "   /usr/share/doc/${PF}/ircd.cron"
	einfo
	einfo "You can also use /etc/init.d/ptlink-ircd to start at boot"
	einfo
}
