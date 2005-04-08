# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.0.9.7.ebuild,v 1.2 2005/04/08 13:55:48 gustavoz Exp $

inherit eutils

DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.freehaven.net/tor/"
SRC_URI="http://tor.eff.org/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~ppc64 ~sparc"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="net-misc/tsocks"

src_unpack() {
	unpack ${A}
	cd ${S}/src/config
	epatch ${FILESDIR}/torrc.sample.patch-00
}

src_install() {
	exeinto /etc/init.d ; newexe ${FILESDIR}/tor.initd tor
	make DESTDIR=${D} install || die

	dodoc README ChangeLog AUTHORS INSTALL \
		doc/{CLIENTS,FAQ,HACKING,TODO} \
		doc/{control-spec.txt,rend-spec.txt,tor-doc.css,tor-doc.html,tor-spec.txt}

	enewgroup tor
	enewuser tor -1 /bin/false /var/lib/tor tor
	dodir /var/lib/tor
	dodir /var/log/tor
	fperms 750 /var/lib/tor /var/log/tor
	fowners tor:tor /var/lib/tor /var/log/tor
}

pkg_postinst() {
	einfo "You must create /etc/tor/torrc, you can use the sample that is in that directory"
	einfo "To have privoxy and tor working together you must add:"
	einfo "forward-socks4a / localhost:9050 ."
	einfo "to /etc/privoxy/config"
}
