# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/unrealircd/unrealircd-3.2_rc1.ebuild,v 1.4 2004/03/06 12:15:13 zul Exp $

MY_P=Unreal3.2-RC1
DESCRIPTION="aimed to be an advanced (not easy) IRCd"
HOMEPAGE="http://www.unrealircd.com/"
SRC_URI="http://www.gower.net/unrealircd/${MY_P}.tar.gz
	ftp://unreal.secure-tech.net/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -*"
IUSE="ssl ipv6 leaf"

DEPEND="ssl? ( dev-libs/openssl )
	>=sys-apps/sed-4"

S=${WORKDIR}/Unreal3.2


src_compile() {
	local myconf=" --enable-nospoof \
	--prefix=/usr \
	--with-dpath=${D}/etc/unrealircd \
	--with-spath=/usr/bin/unrealircd \
	--enable-prefixaq \
	--enable-ziplinks \
	--with-listen=5 \
	--with-nick-history=2000 \
	--with-sendq=3000000 \
	--with-bufferpool=18 \
	--with-hostname=`hostname` \
	--with-permissions=0600 \
	--with-fd-setsize=1024 \
	--enable-dynamic-linking"

	if [ -n "`use ssl`" ] ; then
		einfo "Enabling SSL/Crypto support"
		myconf="${myconf} --enable-ssl"
	fi

	if [ -n "`use ipv6`" ] ; then
		einfo "Enabling IPv6 support"
		myconf="${myconf} --enable-inet6"
	fi

	if [ -n "`use leaf`" ] ; then
		einfo "Enabling ircd as leaf server"
		myconf="${myconf} --enable-leaf"
		sleep 5
	else
		einfo "Enabling ircd as hub server(default)"
		ewarn "Set USE=\"leaf\" if you want a leaf server."
		sleep 5
		myconf="${myconf} --enable-hub"
	fi

	econf ${myconf} || die

	# DPATH and SPATH is hardcoded in include/setup.h
	sed -i 's:/var/tmp/portage/unrealircd-3.2_rc1/image/::' include/setup.h

	emake || die
}

src_install() {
	cd ${S}

	newbin src/ircd unrealircd || die

	if [ -n "`use ssl`" ] ; then
		newbin ${FILESDIR}/mkunrealircd-cert.sh mkunrealircd-cert
	fi

	insinto /etc/unrealircd
	doins badwords.*.conf help.conf

	if [ -n "`use ssl`" ] ; then
		doins src/ssl.cnf
	fi

	insinto /etc/unrealircd/networks
	doins networks/{*.network,makenet,networks.ndx}

	insinto /etc/unrealircd/aliases
	doins aliases/*.conf

	insinto /etc/unrealircd/modules
	doins src/modules/*.so

	dodoc doc/Authors doc/example.conf doc/example.settings
	dodoc doc/coding-guidelines doc/tao.of.irc doc/unreal32docs.html

	exeinto /etc/init.d
	newexe ${FILESDIR}/unrealircd.rc unrealircd

	insinto /etc/conf.d
	newins ${FILESDIR}/unrealircd.confd unrealircd

	into /etc/unrealircd
	dodir /etc/unrealircd/tmp

	chown ircd:ircd /etc/unrealircd/tmp
}

pkg_postinst() {
	einfo "UnrealIRCD will not run until you do a few things ..."
	echo
	einfo "Setup /etc/unrealircd/unrealircd.conf"
	einfo "      see /usr/share/doc/${PF}/example.conf.gz for more info"
	echo
	einfo "You can also use /etc/init.d/unrealircd to start at boot"
	echo
	if [ -n "`use ssl`" ] ; then
		einfo "Run /usr/bin/mkunrealircd-cert to create a default cert for ssl."
		einfo "The cert defaults are in /etc/unrealircd/ssl.cnf edit this prior to running."
		echo
	fi
	einfo "Change the permissions of /etc/unrealircd/tmp to your unrealircd"
	einfo "user."
	echo
}
