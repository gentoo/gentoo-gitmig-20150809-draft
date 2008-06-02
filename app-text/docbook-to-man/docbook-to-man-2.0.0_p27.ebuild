# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-to-man/docbook-to-man-2.0.0_p27.ebuild,v 1.1 2008/06/02 21:09:29 loki_val Exp $

inherit eutils toolchain-funcs

DESCRIPTION="docbook-to-man is a lightweight DocBook -> man converter"
HOMEPAGE="http://packages.qa.debian.org/d/docbook-to-man.html"
SRC_URI="mirror://debian/pool/main/d/docbook-to-man/${PN}_${PV%_p*}.orig.tar.gz
	mirror://debian/pool/main/d/docbook-to-man/${PN}_${PV/_p/-}.diff.gz"
LICENSE="MIT GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}
	=app-text/docbook-sgml-dtd-4.1*
	app-text/opensp"

S=${WORKDIR}/${P%_p*}.orig

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_OPTS="-p1 -g0 -E --no-backup-if-mismatch"
	epatch ../docbook-to-man_2.0.0-27.diff
	epatch "${FILESDIR}/${P%_p*}-makefile.patch"
	EPATCH_SOURCE="${S}/debian/patches"
	EPATCH_SUFFIX="dpatch"
	EPATCH_FORCE="yes"
	EPATCH_MULTI_MSG="Applying Debian patches..."
	epatch
	sed -r -i \
		-e 's:^(DOCBOOK.+)docbook/dtd/4.1:\1docbook/sgml-dtd-4.1\nTPTLIB=$SGMLS/transpec:' \
		cmd/docbook-to-man.sh \
		|| die "Sed for transpec failed"
	sed -i \
		-e 's:$INSTANT -croff.cmap -sroff.sdata -tdocbook-to-man.ts $INSTANT_OPT |:$INSTANT -c$TPTLIB/roff.cmap -s$TPTLIB/roff.sdata -t$TPTLIB/docbook-to-man.ts $INSTANT_OPT |:' \
		-e 's:CATALOG=$DOCBOOK/docbook.cat:CATALOG=$DOCBOOK/catalog:' \
		cmd/docbook-to-man.sh \
		|| die "Sed for catalog, etc. failed"

	sed -i \
		-e 's:#include <tptregexp.h>:#include "tptregexp/tptregexp.h":' \
		$(find Instant -maxdepth 1 -name '*.c') \
		|| die "Sed for tptregexp/tptregexp.h failed"
	sed -i \
		-e 's:#include <tptregexp.h>:#include "tptregexp.h":' \
		$(find Instant/tptregexp -maxdepth 1 -name '*.c') \
		|| die "Sed for tptregexp.h failed"
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake ROOT="${D}/usr" install || die "emake install failed"
	doman Doc/{docbook-to-man.1,instant.1,transpec.1} || die "No manpages"
}
