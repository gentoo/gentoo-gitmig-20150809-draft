# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnucap/gnucap-20060506.ebuild,v 1.1 2006/05/21 17:55:46 calchan Exp $

inherit eutils

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6}"

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://geda.seul.org/dist/gnucap-${MY_PV}.tar.gz"
HOMEPAGE="http://www.geda.seul.org/tools/gnucap"

IUSE="readline"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="readline? (
		sys-libs/readline
		sys-libs/libtermcap-compat )"
S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A} || die "Failed to unpack!"

	# Fix hardcoded CXXFLAGS and LDFLAGS
	epatch ${FILESDIR}/gnucap-flags.patch || die "epatch failed"

	# Don't let gnucap decide whether to use readline
	if ! use readline ; then
		epatch ${FILESDIR}/gnucap-no-readline.patch || die "epatch failed"
	fi
}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	insinto /usr/bin
	doins src/O/gnucap
	fperms 755 /usr/bin/gnucap

	dodoc man/gnucap-man.pdf
	cd doc
	doman gnucap.1 gnucap-ibis.1
	dodoc acs-tutorial history whatisit
}
