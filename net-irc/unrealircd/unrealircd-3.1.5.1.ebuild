# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/unrealircd/unrealircd-3.1.5.1.ebuild,v 1.3 2003/03/25 22:47:03 seemant Exp $

IUSE="ssl"

MY_P="Unreal${PV}"

S=${WORKDIR}/${MY_P}
DESCRIPTION="aimed to be an advanced, not an easy IRCd"
HOMEPAGE="http://www.unrealircd.com/"
SRC_URI="http://www.gower.net/unrealircd/${MY_P}-Valek.tar.gz
	ftp://unreal.secure-tech.net/${MY_P}-Valek.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="ssl? ( dev-libs/openssl )"


src_unpack() {
	unpack ${A} && cd ${S}
	rm -f .CHANGES.NEW .RELEASE.NOTES
	epatch ${FILESDIR}/${P}-Config.patch

	cp Config{,.orig}
	sed -e "s:GENTOO_CFLAGS:${CFLAGS}:" \
		Config.orig > Config
}

src_compile() {
	./Config || die "configure failed"
	make || die "compiling failed"
}

src_install() {
	newbin src/ircd unrealircd || die
	newbin makeconf unrealircd-makeconf || die
	newbin src/chkconf unrealircd-chkconf || die

	insinto /etc/unrealircd
	doins badwords.*.conf
	insinto /etc/unrealircd/networks
	doins networks/{template.network,unrealircd.conf}

	dodoc doc/* Changes Donation Unreal.nfo dynconf ircdcron/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/unrealircd.rc unrealircd
	insinto /etc/conf.d
	newins ${FILESDIR}/unrealircd.confd unrealircd
}

pkg_postinst() {
	einfo "UnrealIRCD will not run until you do a few things ..."
	echo
	einfo "Setup /etc/unrealircd/unrealircd.conf"
	einfo "      see /etc/unrealircd/template.network for more info"
	einfo "Setup /etc/unrealircd/ircd.conf"
	einfo "      see /usr/share/doc/${PF}/example.conf.gz for more info"
	echo
	einfo "You can find example cron scripts here:"
	einfo "   /usr/share/doc/${PF}/ircd.cron"
	einfo "   /usr/share/doc/${PF}/ircdchk"
	einfo "You can also use /etc/init.d/unrealircd to start at boot"
}
