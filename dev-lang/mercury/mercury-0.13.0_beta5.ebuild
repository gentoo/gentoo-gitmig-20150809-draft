# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mercury/mercury-0.13.0_beta5.ebuild,v 1.1 2006/04/25 01:18:00 keri Exp $

inherit eutils versionator

BETA_V=$(get_version_component_range 4 $PV)
MY_PV=$(get_version_component_range 1-3 $PV)-beta
MY_P=${PN}-compiler-${MY_PV}-2006-04-23

DESCRIPTION="Mercury is a modern general-purpose logic/functional programming language"
HOMEPAGE="http://www.cs.mu.oz.au/research/mercury/index.html"
SRC_URI="ftp://ftp.mercury.cs.mu.oz.au/pub/${PN}/beta-releases/${MY_PV}/${MY_P}-unstable.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE="minimal readline"

DEPEND="readline? ( sys-libs/readline )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-portage.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-CFLAGS.patch
	epatch "${FILESDIR}"/${P/${BETA_V}/beta}-docs.patch
}

src_compile() {
	econf \
		--disable-dotnet-grades \
		$(use_enable !minimal most-grades) \
		$(use_with readline) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make \
		MERCURY_COMPILER="${D}"/usr/bin/${PN}_compile \
		INSTALL_PREFIX="${D}"/usr \
		INSTALL_MAN_DIR="${D}"/usr/share/man \
		INSTALL_INFO_DIR="${D}"/usr/share/info \
		INSTALL_HTML_DIR="${D}"/usr/share/doc/${PF}/html \
		install || die "make install failed"

	dodoc BUGS HISTORY LIMITATIONS NEWS README README.Java README.Linux README.Linux-Alpha README.Linux-m68k README.Linux-PPC RELEASE_NOTES TODO VERSION WORK_IN_PROGRESS
}
