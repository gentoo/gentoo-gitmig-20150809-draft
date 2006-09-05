# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/ng-spice-rework/ng-spice-rework-17-r1.ebuild,v 1.2 2006/09/05 18:26:10 gustavoz Exp $

inherit eutils

DESCRIPTION="The Next Generation Spice (Electronic Circuit Simulator)."
SRC_URI="mirror://sourceforge/ngspice/${P}.tar.gz"
HOMEPAGE="http://ngspice.sourceforge.net"
LICENSE="BSD GPL-2"

SLOT="0"
IUSE="readline debug"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="readline? ( >=sys-libs/readline-5.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-com_let.patch
	epatch ${FILESDIR}/${PN}-numparam.patch
	epatch ${FILESDIR}/${PN}-pipemode.patch
	epatch ${FILESDIR}/${PN}-postscript.patch
}

src_compile() {
	econf \
		--enable-numparam \
		--enable-dot-global \
		--disable-dependency-tracking \
		$(use_with debug) \
		$(use_with readline) || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	local infoFile
	for infoFile in doc/ngspice.info*; do
		echo 'INFO-DIR-SECTION EDA' >> ${infoFile}
		echo 'START-INFO-DIR-ENTRY' >> ${infoFile}
		echo '* NGSPICE: (ngspice). Electronic Circuit Simulator.' >> ${infoFile}
		echo 'END-INFO-DIR-ENTRY' >> ${infoFile}
	done

	make DESTDIR="${D}" install || die "make install failed"
	dodoc ANALYSES AUTHORS BUGS ChangeLog DEVICES NEWS \
		README Stuarts_Poly_Notes || die "failed to install documentation"

	# We don't need makeidx to be installed
	rm ${D}/usr/bin/makeidx
}

src_test () {
	# Bug 108405
	true
}
