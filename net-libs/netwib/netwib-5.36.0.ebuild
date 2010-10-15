# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/netwib/netwib-5.36.0.ebuild,v 1.2 2010/10/15 16:10:52 phajdan.jr Exp $

# NOTE: netwib, netwox and netwag go together, bump all or bump none

EAPI="2"

inherit toolchain-funcs multilib

DESCRIPTION="Library of Ethernet, IP, UDP, TCP, ICMP, ARP and RARP protocols"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwib/"

BASEURI="http://www.laurentconstantin.com/common/netw/${PN}/download/"
SRC_URI="
	${BASEURI}v${PV/.*}/${P}-src.tgz
	doc? ( ${BASEURI}v${PV/.*}/${P}-doc_html.tgz )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc x86"
IUSE="doc"

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.1"

S="${WORKDIR}/${P}-src/src"

src_prepare() {
	sed -i \
		-e 's:/man$:/share/man:g' \
		-e "s:/lib:/$(get_libdir):" \
		-e "s:/usr/local:/usr:" \
		-e "s:=ar:=$(tc-getAR):" \
		-e "s:=ranlib:=$(tc-getRANLIB):" \
		-e "s:=gcc:=$(tc-getCC):" \
		-e "s:-O2:${CFLAGS}:" \
		config.dat
}

src_configure() {
	sh genemake || die "problem creating Makefile"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ../README.TXT
	if use doc; then
		mv "${WORKDIR}"/${P}-doc_html "${D}"/usr/share/doc/${PF}/html
	else
		cd "${S}"/..
		dodoc doc/{changelog.txt,credits.txt,integration.txt} \
			doc/{problemreport.txt,problemusageunix.txt,todo.txt}
	fi
}
