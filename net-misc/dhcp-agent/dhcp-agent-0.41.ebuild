# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp-agent/dhcp-agent-0.41.ebuild,v 1.5 2006/02/20 20:43:49 jokey Exp $

inherit eutils

DESCRIPTION="dhcp-agent is a portable UNIX Dynamic Host Configuration suite"
HOMEPAGE="http://dhcp-agent.sourceforge.net/"
SRC_URI="mirror://sourceforge/dhcp-agent/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="doc"

DEPEND=">=dev-libs/libdnet-1.7
	net-libs/libpcap
	>=dev-util/guile-1.6.4
	doc? ( app-text/texi2html )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:\(LDADD = \)-ldhcputil:\1-L${S}/src/.libs/ libdhcputil.la:g" \
		-e 's:\(mkdir -p \).*\$\(.*\)\$\(.*\)\$\(.*\):\1\$(DESTDIR)\$\2\$(DESTDIR)\$\3\$(DESTDIR)\$\4:' \
		src/Makefile.am || die "sed Makefile.am failed"
	sed -i "s:^\(dhcpdocdir=\).*$:\"\1/share/doc/${PF}\":" configure.ac || \
		die "sed configure.ac failed"
	epatch ${FILESDIR}/${P}-bpf.diff
}

src_compile() {
	autoreconf -fi || die "autoreconf failed"
	econf $(use_enable doc htmldoc) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README THANKS TODO UPGRADING CAVEATS
}
