# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/srvx/srvx-1.3_p84.ebuild,v 1.1 2004/12/16 16:08:53 swegener Exp $

inherit eutils

MY_P=${P/_/-}

DESCRIPTION="A complete set of services for IRCu 2.10.10+ and bahamut based networks"
HOMEPAGE="http://www.srvx.net/"
SRC_URI="http://www.macs.hw.ac.uk/~sa3/pub/srvx/${MY_P}.tar.bz2
	http://srvx.arlott.org/arch/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="bahamut"

DEPEND=">=sys-devel/automake-1.8
	>=sys-devel/autoconf-2.59"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	local PROTOCOL="p10"
	use bahamut && PROTOCOL="bahamut"

	./autogen.sh || die "autogen.sh failed"

	econf \
		--with-protocol=$PROTOCOL \
		--enable-modules=helpserv,memoserv,sockcheck \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	dobin src/srvx || die "dobin failed"
	dodir /var/lib/srvx || die "dodir failed"

	insinto /etc/srvx
	newins srvx.conf.example srvx.conf || die "newins failed"
	newins sockcheck.conf.example sockcheck.conf || die "newins failed"
	dosym ../../../etc/srvx/srvx.conf /var/lib/srvx/srvx.conf || die "dosym failed"
	dosym ../../../etc/srvx/sockcheck.conf /var/lib/srvx/sockcheck.conf || die "dosym failed"

	insinto /usr/share/srvx
	for helpfile in \
		chanserv.help global.help nickserv.help opserv.help \
		modcmd.help saxdb.help sendmail.help mod-helpserv.help \
		mod-memoserv.help mod-sockcheck.help
	do
		doins "${helpfile}" || die "doins failed"
		dosym "../../../usr/share/srvx/${helpfile}" "/var/lib/srvx/${helpfile}" || die "dosym failed"
	done

	dodoc AUTHORS FAQ INSTALL NEWS README TODO srvx.conf.example sockcheck.conf.example || die "dodoc failed"

	newinitd ${FILESDIR}/srvx.init.d srvx || die "newinitd failed"
	newconfd ${FILESDIR}/srvx.conf.d srvx || die "newconfd failed"
}

pkg_setup() {
	enewgroup srvx
	enewuser srvx -1 /bin/false /var/lib/srvx srvx
}

pkg_postinst() {
	chown -R srvx:srvx ${ROOT}/etc/srvx ${ROOT}/var/lib/srvx
	chmod 0700 ${ROOT}/etc/srvx ${ROOT}/var/lib/srvx
}
