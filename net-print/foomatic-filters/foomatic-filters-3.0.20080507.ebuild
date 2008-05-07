# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-filters/foomatic-filters-3.0.20080507.ebuild,v 1.1 2008/05/07 23:15:51 tgurr Exp $

inherit autotools eutils versionator

MY_P=${PN}-$(replace_version_separator 2 '-')
DESCRIPTION="Foomatic wrapper scripts"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${MY_P}.tar.gz
	http://www.linuxprinting.org/download/foomatic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="cups"

RDEPEND="cups? ( >=net-print/cups-1.1.19 )
	!cups? (
		|| (
			app-text/enscript
			app-text/a2ps
			app-text/mpage
		)
	)
	dev-lang/perl
	virtual/ghostscript"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use cups; then
		CUPS_SERVERBIN="$(cups-config --serverbin)"
	else
		CUPS_SERVERBIN=""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Search for libs in ${libdir}, not just /usr/lib
	epatch "${FILESDIR}/foomatic-filters-3.0.20060601-multilib.patch"
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	export CUPS_BACKENDS=${CUPS_SERVERBIN}/backend \
		CUPS_FILTERS=${CUPS_SERVERBIN}/filter CUPS=${CUPS_SERVERBIN}/
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dosym /usr/bin/foomatic-rip /usr/bin/lpdomatic

	if use cups; then
		dosym /usr/bin/foomatic-gswrapper ${CUPS_SERVERBIN}/filter/foomatic-gswrapper
		dosym /usr/bin/foomatic-rip ${CUPS_SERVERBIN}/filter/cupsomatic
	else
		rm -r "${D}"/${CUPS_SERVERBIN}/filter
		rm -r "${D}"/${CUPS_SERVERBIN}/backend
	fi
}
