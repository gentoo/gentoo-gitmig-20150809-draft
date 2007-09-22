# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libeXosip/libeXosip-2.2.3.ebuild,v 1.2 2007/09/22 14:35:38 philantrop Exp $

inherit flag-o-matic

MY_P=${PN}2-${PV/_/-}
DESCRIPTION="eXosip is a library that hides the complexity of using the SIP protocol for multimedia session establishement."
HOMEPAGE="http://savannah.nongnu.org/projects/exosip/"
SRC_URI="http://www.antisip.com/download/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
IUSE=""
DEPEND=">=net-libs/libosip-2.2.1"
#		josua? ( >=net-libs/ortp-0.7.1 )"
S=${WORKDIR}/${MY_P}

src_compile() {
	append-cflags "-I/usr/include/glib-2.0"
	econf --disable-josua || die # $(use_enable josua) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog AUTHORS NEWS eXosip_addidentity.sh
}
