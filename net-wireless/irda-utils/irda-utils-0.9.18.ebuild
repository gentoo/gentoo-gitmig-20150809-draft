# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/irda-utils/irda-utils-0.9.18.ebuild,v 1.1 2007/09/25 15:34:21 hanno Exp $

inherit eutils

DESCRIPTION="IrDA utilities for infrared communication"
HOMEPAGE="http://irda.sourceforge.net"
SRC_URI="mirror://sourceforge/irda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh ~x86"
IUSE=""

RDEPEND="=dev-libs/glib-2*"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/irda-utils-rh1.patch"
	epatch "${FILESDIR}/irda-utils-0.9.18-makefile.diff"
	epatch "${FILESDIR}/irda-utils-0.9.18-io.h.diff"
}

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS}" RPM_BUILD_ROOT="${D}" ROOT="${D}" \
		|| die "emake failed"
}

src_install () {
	dodir /usr/bin
	dodir /usr/sbin

	emake install RPM_OPT_FLAGS="${CFLAGS}" ROOT="${D}" \
		MANDIR="${D}/usr/share/man" \
		|| die "emake install failed"

	dodoc README
	newdoc ethereal/README  README.wireshark
	newdoc irattach/README  README.irattach
	newdoc irdadump/README  README.irdadump
	newdoc irdaping/README  README.irdaping
	newdoc irsockets/README README.irsockets
	newdoc tekram/README    README.tekram

	newdoc irattach/ChangeLog ChangeLog.irattach
	newdoc irdadump/ChangeLog ChangeLog.irdadump

	dodoc etc/modules.conf.irda

	newconfd "${FILESDIR}/irda.conf" irda
	newinitd "${FILESDIR}/irda.rc" irda
}
