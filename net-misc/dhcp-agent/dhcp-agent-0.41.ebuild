# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp-agent/dhcp-agent-0.41.ebuild,v 1.2 2005/01/29 21:21:55 dragonheart Exp $

DESCRIPTION="dhcp-agent is a portable UNIX Dynamic Host Configuration suite"
HOMEPAGE="http://dhcp-agent.sourceforge.net/"
SRC_URI="mirror://sourceforge/dhcp-agent/${P}.tar.gz"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~sparc"
IUSE="doc"

DEPEND=">=dev-libs/libdnet-1.7
	virtual/libpcap
	>=dev-util/guile-1.6.4
	doc? ( app-text/texi2html )"

src_unpack() {
	unpack ${A}
	#sed -i -e "s:LDADD = -ldhcputil:LDADD = -L${S}/src/.libs -ldhcputil:g" ${S}/src/Makefile.in
	sed -i -e "s:LDADD = -ldhcputil:LDADD = -L${S}/src/.libs/ libdhcputil.la:g" \
		-e 's:${dhcplocalstate:$(DESTDIR)${dhcplocalstate:g' ${S}/src/Makefile.in

}

src_compile() {
	econf `use_enable doc htmldoc` || die
	emake -j1 || die
	sed -i -e "s:/usr/doc/dhcp-agent:/usr/share/doc/${PF}:" ${S}/man/dhcp-*.1
}

src_install() {
	emake DESTDIR=${D} dhcpdocdir=/share/doc/${PF} install || die
	dodoc README THANKS TODO UPGRADING CAVEATS
}
