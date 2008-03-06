# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/irda-utils/irda-utils-0.9.18-r1.ebuild,v 1.1 2008/03/06 21:15:00 sbriesen Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="IrDA utilities for infrared communication"
HOMEPAGE="http://irda.sourceforge.net"
SRC_URI="mirror://sourceforge/irda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh ~x86"
IUSE=""

RDEPEND="=dev-libs/glib-2*
	>=sys-apps/pciutils-2.2.7-r1"
DEPEND="${RDEPEND}
	!app-laptop/smcinit
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/irda-utils-rh1.patch"
	epatch "${FILESDIR}/irda-utils-0.9.18-makefile.diff"
	epatch "${FILESDIR}/irda-utils-0.9.18-io.h.diff"

	# fix crosscompile, respect CFLAGS (Bug 200295)
	sed -i -e "/^CC/s:gcc:$(tc-getCC):" \
		-e "/^LD/s:ld:$(tc-getLD):" \
		-e "/^AR/s:ar:$(tc-getAR):" \
		-e "/^RANLIB/s:ranlib:$(tc-getRANLIB):" \
		-e "/^CFLAGS/s:-O2:${CFLAGS}:" Makefile */Makefile

	# fix compile when pciutils is compiled with USE=zlib (Bug 200295)
	sed -i -e "s:-lpci:$(pkg-config --libs libpci):g" smcinit/Makefile

	append-flags "-fno-strict-aliasing"
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

	newdoc ethereal/README     README.wireshark
	newdoc irattach/README     README.irattach
	newdoc irdadump/README     README.irdadump
	newdoc irdaping/README     README.irdaping
	newdoc irsockets/README    README.irsockets
	newdoc tekram/README       README.tekram
	newdoc smcinit/README      README.smcinit
	newdoc smcinit/README.Peri README.smcinit.Peri
	newdoc smcinit/README.Rob  README.smcinit.Rob
	newdoc smcinit/README.Tom  README.smcinit.Tom
	newdoc irattach/ChangeLog  ChangeLog.irattach
	newdoc irdadump/ChangeLog  ChangeLog.irdadump
	newdoc smcinit/ChangeLog   ChangeLog.smcinit
	dohtml smcinit/RobMiller-irda.html
	dodoc README etc/modules.conf.irda

	newconfd "${FILESDIR}/irda.conf" irda
	newinitd "${FILESDIR}/irda.rc" irda

	insinto /etc/udev/rules.d
	newins "${FILESDIR}/irda-usb.rules" 53-irda-usb.rules
	exeinto /lib/udev
	doexe "${FILESDIR}/irda-usb.sh"
}
