# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/p0f/p0f-2.0.5-r1.ebuild,v 1.3 2006/02/15 23:43:40 jokey Exp $

inherit eutils

DESCRIPTION="p0f performs passive OS detection based on SYN packets."
HOMEPAGE="http://lcamtuf.coredump.cx/p0f.shtml"
SRC_URI="http://lcamtuf.coredump.cx/p0f/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sparc ~x86"
IUSE="static"

DEPEND="net-libs/libpcap"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A} && cd ${S}
	sed -i 's;#include <net/bpf.h>;;' p0f.c || die "sed p0f.c failed"
	sed -i -e 's|^\(all: $(FILE)\).*$|\1|' \
		-e "s|^\(CFLAGS.*=\).*$|\1${CFLAGS}|" mk/* || die "sed makefiles failed"
}

src_compile() {
	local static
	use static && static="static"
	emake ${static} || die "emake ${static} failed"
}

src_install () {
	use static && mv p0f-static p0f
	dosbin p0f p0frep || die

	insinto /etc/p0f
	doins p0f.fp p0fa.fp p0fr.fp

	doman p0f.1 || die
	cd doc
	dodoc ChangeLog CREDITS KNOWN_BUGS README TODO

	insinto /etc/conf.d ; newins ${FILESDIR}/${PN}.confd ${PN}
	newinitd ${FILESDIR}/${PN}.initd2 ${PN} || die "newinitd failed"
}

pkg_postinst(){
	einfo "Adjust /etc/conf.d/p0f to your liking before using the"
	einfo "init script. For more information on options, read man p0f."
}
