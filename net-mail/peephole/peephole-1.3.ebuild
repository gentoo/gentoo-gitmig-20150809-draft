# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/peephole/peephole-1.3.ebuild,v 1.1 2004/06/29 09:03:55 s4t4n Exp $

DESCRIPTION="A daemon that polls your POP servers, checking if there are messages from particular persons."
HOMEPAGE="http://peephole.sourceforge.net/"
SRC_URI="mirror://sourceforge/peephole/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

# This program supports the nptl, but there is no need
# for ebuild code to enable them...
IUSE="nptl"

DEPEND=">=dev-libs/openssl-0.9.7d-r1"

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS COPYING README
}

pkg_postinst()
{
	einfo "Before you can use peephole you must copy"
	einfo "/etc/skel/.peephole.providers and /etc/skel/.peepholerc"
	einfo "to your home dir and edit them to suit your needs."
	sleep 5
}
