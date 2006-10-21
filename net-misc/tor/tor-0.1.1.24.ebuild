# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.1.1.24.ebuild,v 1.2 2006/10/21 16:22:10 humpback Exp $

inherit eutils

DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://tor.eff.org"
SRC_URI="http://tor.eff.org/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/openssl
	dev-libs/libevent"
RDEPEND="net-proxy/tsocks"

pkg_setup() {
	enewgroup tor
	enewuser tor -1 -1 /var/lib/tor tor
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/torrc.sample-0.1.1.23.patch
}

src_install() {
	exeinto /etc/init.d ; newexe ${FILESDIR}/tor.initd tor
	make DESTDIR=${D} install || die

	dodoc README ChangeLog AUTHORS INSTALL \
		doc/{HACKING,TODO} \
		doc/{control-spec.txt,dir-spec.txt,rend-spec.txt,socks-extensions.txt,tor-spec.txt}

	dodir /var/lib/tor
	dodir /var/log/tor
	dodir /var/run/tor
	fperms 750 /var/lib/tor /var/log/tor
	fperms 755 /var/run/tor
	fowners tor:tor /var/lib/tor /var/log/tor /var/run/tor
}

pkg_postinst() {
	einfo "You must create /etc/tor/torrc, you can use the sample that is in that directory"
	einfo "To have privoxy and tor working together you must add:"
	einfo "forward-socks4a / localhost:9050 ."
	ewarn "(notice the . at the end of the line)"
	einfo "to /etc/privoxy/config"
}
