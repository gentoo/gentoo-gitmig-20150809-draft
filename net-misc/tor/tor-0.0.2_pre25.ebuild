# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.0.2_pre25.ebuild,v 1.1 2004/03/04 22:11:56 latexer Exp $

MY_P=${P/_pre/pre}
DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.freehaven.net/tor/"
SRC_URI="http://www.freehaven.net/tor/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="net-misc/tsocks"
S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README ChangeLog AUTHORS \
		doc/{CLIENTS,FAQ,HACKING,TODO} \
		doc/{rendezvous.txt,tor-design.tex,tor-spec.txt}
}
