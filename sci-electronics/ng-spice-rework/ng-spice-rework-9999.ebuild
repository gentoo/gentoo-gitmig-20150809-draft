# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/ng-spice-rework/ng-spice-rework-9999.ebuild,v 1.5 2010/06/24 10:44:53 jlec Exp $

inherit eutils cvs

ECVS_SERVER="ngspice.cvs.sourceforge.net:/cvsroot/ngspice"
ECVS_MODULE="ngspice/ng-spice-rework"
ECVS_USER="anonymous"

DESCRIPTION="The Next Generation Spice (Electronic Circuit Simulator) from CVS HEAD."
SRC_URI=""
HOMEPAGE="http://ngspice.sourceforge.net"
LICENSE="BSD GPL-2"

SLOT="0"
IUSE="readline debug"
KEYWORDS=""

DEPEND="readline? ( >=sys-libs/readline-5.0 )"

S="${WORKDIR}"/ngspice/ng-spice-rework

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-com_let.patch
	epatch "${FILESDIR}"/${PN}-numparam.patch
	epatch "${FILESDIR}"/${PN}-pipemode.patch
	epatch "${FILESDIR}"/${PN}-postscript.patch

	# Getting rid of this for now
	sed -i -e "/src\/spicelib\/devices\/adms\//d" configure.in
}

src_compile() {
	./autogen.sh
	econf \
		--enable-maintainer-mode \
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
	rm "${D}"/usr/bin/makeidx
}

src_test () {
	# Bug 108405
	true
}
