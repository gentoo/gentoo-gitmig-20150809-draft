# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/omni/omni-0.9.2.ebuild,v 1.9 2008/11/23 19:25:07 halcy0n Exp $

WANT_AUTOMAKE="1.6"
WANT_AUTOCONF="latest"

inherit eutils autotools

DESCRIPTION="Omni provides support for many printers with a pluggable framework (easy to add devices)"
HOMEPAGE="http://sourceforge.net/projects/omniprint"
SRC_URI="mirror://sourceforge/omniprint/${P/o/O}.tar.gz
	doc? ( mirror://sourceforge/omniprint/OmniArchitecture.0.3.pdf )
	epson? ( mirror://sourceforge/omniprint/OmniEpsonVendor-${PV}.tar.gz )
	foomaticdb? ( mirror://gentoo/omni-${PV}-foomatic.tar.bz2 )"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
DEPEND=""
RDEPEND="virtual/ghostscript
	dev-libs/libxml2
	=dev-libs/glib-1*
	cups? ( >=net-print/cups-1.1.14 )
	X? ( =dev-cpp/gtkmm-1.2* )
	=dev-libs/libsigc++-1.0*
	foomaticdb? ( net-print/foomatic-db-engine )"

S="${WORKDIR}/Omni"

IUSE="cups X ppds foomaticdb static doc epson"

src_unpack() {
	unpack ${P/o/O}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/Omni-0.9.2-gcc43.patch
	if use epson; then
		unpack OmniEpsonVendor-${PV}.tar.gz
		epatch "${FILESDIR}"/OmniEpsonVendor-0.9.2-gcc43.patch
	fi
}

src_compile() {
	local myconf=" \
		$(use_enable X jobdialog) \
		$(use_enable cups) \
		$(use_enable static)"

	eautoreconf

	LC_ALL="" LC_NUMERIC="" LANG="" ./setupOmni ${myconf} --disable-device-xml --enable-device-compile \
		|| die "setup0mni failed"

	if use ppds && use cups; then
		sed -i -e "s/model\/foomatic/model\/omni/g" CUPS/Makefile \
			|| die 'sed failed'
		make -C CUPS generateBuildPPDs || die "make failed"
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc docs/*  # never forget this! ;-)
	use doc && dodoc "${DISTDIR}"/OmniArchitecture.0.3.pdf

	if use foomaticdb; then
		cd "${D}"
		unpack omni-${PV}-foomatic.tar.bz2
	fi
}
