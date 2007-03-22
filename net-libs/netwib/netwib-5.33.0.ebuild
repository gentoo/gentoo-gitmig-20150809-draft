# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/netwib/netwib-5.33.0.ebuild,v 1.3 2007/03/22 14:58:45 gustavoz Exp $

# NOTE: netwib, netwox and netwag go together, bump all or bump none

inherit toolchain-funcs multilib

DESCRIPTION="Library of Ethernet, IP, UDP, TCP, ICMP, ARP and RARP protocols"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwib/"
SRC_URI="http://www.laurentconstantin.com/common/netw/netwib/download/v${PV/.*}/${P}-src.tgz
	doc? (
	http://www.laurentconstantin.com/common/netw/netwib/download/v${PV/.*}/${P}-doc_html.tgz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE="doc"

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.1"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	sed -i \
		-e 's:/man$:/share/man:g' \
		-e "s:/lib:/$(get_libdir):" \
		-e "s:/usr/local:/usr:" \
		-e "s:=ar:=$(tc-getAR):" \
		-e "s:=ranlib:=$(tc-getRANLIB):" \
		-e "s:=gcc:=$(tc-getCC):" \
		-e "s:-O2:${CFLAGS}:" \
		config.dat

	./genemake || die "problem creating Makefile"
}

src_compile() {
	cd src
	emake || die "compile problem"
}

src_install() {
	dodoc README.TXT
	if use doc;
	then
		mv "${WORKDIR}"/${P}-doc_html "${D}"/usr/share/doc/${PF}/html
	else
		dodoc doc/{changelog.txt,credits.txt,integration.txt} \
			doc/{problemreport.txt,problemusageunix.txt,todo.txt}
	fi
	cd src
	make install DESTDIR="${D}" || die
	#rm -rf ${D}/var
}
