# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.0.9.2.ebuild,v 1.1 2005/01/04 18:50:58 latexer Exp $

DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.freehaven.net/tor/"
SRC_URI="http://www.freehaven.net/tor/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="net-misc/tsocks"

src_install() {
	make DESTDIR=${D} install || die

	dodoc README ChangeLog AUTHORS \
		doc/{CLIENTS,FAQ,HACKING,TODO} \
		doc/{rendezvous.txt,tor-design.tex,tor-spec.txt}
}
