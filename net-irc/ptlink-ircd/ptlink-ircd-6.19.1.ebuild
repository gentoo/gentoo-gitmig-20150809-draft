# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ptlink-ircd/ptlink-ircd-6.19.1.ebuild,v 1.3 2004/11/25 21:32:02 swegener Exp $

inherit eutils ssl-cert

MY_P="PTlink${PV}"

DESCRIPTION="PTlink IRCd is a secure IRC daemon with many advanced features."
HOMEPAGE="http://www.ptlink.net/"
SRC_URI="ftp://ftp.sunsite.dk/projects/ptlink/ircd/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

IUSE="ssl"
DEPEND="sys-libs/zlib
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	find ${S} -type d -name CVS -exec rm -rf {} \; 2>/dev/null
}

src_compile() {
	econf \
		--disable-ipv6 \
		$(use_with ssl ssl openssl) \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newbin src/ircd ptlink-ircd || die "newbin failed"
	newbin tools/fixklines ptlink-ircd-fixklines || die "newbin failed"
	newbin tools/mkpasswd ptlink-ircd-mkpasswd || die "newbin failed"

	insinto /etc/ptlink-ircd
	fperms 700 /etc/ptlink-ircd || die "fperms failed"
	doins samples/{kline.conf,{opers,ptlink}.motd,help.{admin,oper,user}} || die "newins failed"
	newins samples/example.conf.short ircd.conf || die "newins failed"
	newins samples/example.conf.trillian ircd.conf.trillian || die "newins failed"
	newins samples/main.dconf.sample main.dconf || die "newins failed"
	newins samples/network.dconf.sample network.dconf || die "newins failed"

	insinto /usr/share/ptlink-ircd/codepage
	doins src/codepage/*.enc || die "doins failed"
	dosym /usr/share/ptlink-ircd/codepage /etc/ptlink-ircd/codepage || die "dosym failed"

	rm -rf doc/old
	dodoc doc/* doc_hybrid6/* ircdcron/* CHANGES README || die "dodoc failed"

	keepdir /var/log/ptlink-ircd /var/lib/ptlink-ircd || die "keepdir failed"
	dosym /var/log/ptlink-ircd /var/lib/ptlink-ircd/log || die "dosym failed"

	newinitd ${FILESDIR}/ptlink-ircd.init.d ptlink-ircd || die "newinitd failed"
	newconfd ${FILESDIR}/ptlink-ircd.conf.d ptlink-ircd || die "newconfd failed"

	use ssl && (
		insinto /etc/ptlink-ircd
		docert server || die "docert failed"
		mv ${D}/etc/ptlink-ircd/server.crt ${D}/etc/ptlink-ircd/server.cert.pem
		mv ${D}/etc/ptlink-ircd/server.csr ${D}/etc/ptlink-ircd/server.req.pem
		mv ${D}/etc/ptlink-ircd/server.key ${D}/etc/ptlink-ircd/server.key.pem
	)
}

pkg_postinst() {
	enewuser ptlink-ircd

	chown ptlink-ircd \
		${ROOT}/{etc,var/{log,lib}}/ptlink-ircd \
		${ROOT}/etc/ptlink-ircd/server.key.pem

	einfo
	einfo "PTlink IRCd will run without configuration, although this is strongly"
	einfo "advised against."
	einfo
	einfo "You can find example cron scripts here:"
	einfo "   /usr/share/doc/${PF}/ircd.cron.gz"
	einfo
	einfo "You can also use /etc/init.d/ptlink-ircd to start at boot"
	einfo
}
