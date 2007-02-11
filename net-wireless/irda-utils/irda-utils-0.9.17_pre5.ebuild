# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/irda-utils/irda-utils-0.9.17_pre5.ebuild,v 1.8 2007/02/11 11:07:38 vapier Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.4"

inherit eutils autotools

MY_P=${PN}-${PV/_/-}
S=${WORKDIR}/${MY_P/-pre*/}

DESCRIPTION="IrDA utilities for infrared communication"
HOMEPAGE="http://irda.sourceforge.net"
SRC_URI="http://www.hpl.hp.com/personal/Jean_Tourrilhes/IrDA/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sh ~x86"
IUSE="gtk"

RDEPEND="=dev-libs/glib-2*
	gtk? ( =x11-libs/gtk+-1.2* )"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/irda-utils-rh1.patch"

	sed -i \
		-e "s:^\(CFLAGS\)=.*:\1=${CFLAGS}:" \
		-e "s:^\(DIRS =.*\):\1 irsockets:" \
		"${S}/Makefile"
}

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS}" RPM_BUILD_ROOT="${D}" ROOT="${D}" WANT_AUTOCONF="2.5" \
		|| die "emake failed"

	if use gtk; then
		emake RPM_OPT_FLAGS="${CFLAGS}" RPM_BUILD_ROOT="${D}" ROOT="${D}" -C findchip gfindchip \
			|| die "emake gfindchip failed"
	fi
}

src_install () {
	dodir /usr/bin
	dodir /usr/sbin

	emake install RPM_OPT_FLAGS="${CFLAGS}" RPM_BUILD_ROOT="${D}" ROOT="${D}" PREFIX="${D}" \
		MANDIR="${D}/usr/share/man" \
		|| die "emake install failed"

	into /usr
	dobin irsockets/irdaspray
	dobin irsockets/ias_query
	dobin irsockets/irprintf
	dobin irsockets/irprintfx
	dobin irsockets/irscanf
	dobin irsockets/recv_ultra
	dobin irsockets/send_ultra

	if use gtk; then
		dosbin findchip/gfindchip
	fi

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

	newconfd ${FILESDIR}/irda.conf irda
	newinitd ${FILESDIR}/irda.rc irda
}
