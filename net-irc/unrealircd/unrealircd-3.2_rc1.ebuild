# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/unrealircd/unrealircd-3.2_rc1.ebuild,v 1.1 2004/02/21 02:42:37 zul Exp $

MY_P=Unreal3.2-RC1
DESCRIPTION="aimed to be an advanced (not easy) IRCd"
HOMEPAGE="http://www.unrealircd.com/"
SRC_URI="http://www.gower.net/unrealircd/${MY_P}.tar.gz
	ftp://unreal.secure-tech.net/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )
	>=sys-apps/sed-4"

S=${WORKDIR}/Unreal3.2

src_unpack() {
	unpack ${A} && cd ${S}
	rm -f .CHANGES.NEW .RELEASE.NOTES
#	epatch ${FILESDIR}/${PV}-Config.patch
#	sed -i 's:^ID_CVS.*::' src/res_mkquery.c

#	cp Config{,.orig}
#	sed -e "s:GENTOO_CFLAGS:${CFLAGS}:" \
#		Config.orig > Config
}

src_compile() {
	./Config -quick || die "configure failed"
	make RES="res_init.o res_comp.o res_mkquery.o" \
		|| die "compiling failed"
}

src_install() {
	newbin src/ircd unrealircd || die

	insinto /etc/unrealircd
	doins badwords.*.conf
	insinto /etc/unrealircd/networks
	doins networks/{template.network,unrealircd.conf}

	rm -rf ircdcron/CVS
	rm -rf doc/CVS
	rm -rf doc/technical/CVS
	dodoc doc/* Changes Donation Unreal.nfo ircdcron/*

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
	echo
	einfo "You can also use /etc/init.d/unrealircd to start at boot"
	echo
}
