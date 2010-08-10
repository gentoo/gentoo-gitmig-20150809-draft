# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jove/jove-4.16.0.70.3.1.ebuild,v 1.8 2010/08/10 19:29:17 ulm Exp $

inherit eutils toolchain-funcs versionator

MY_P=${PN}_$(get_version_component_range 1-4)
MY_DIFFP=${MY_P}-$(get_version_component_range 5-6)

DESCRIPTION="Jonathan's Own Version of Emacs - a light emacs-like editor without LISP bindings"
HOMEPAGE="ftp://ftp.cs.toronto.edu/cs/ftp/pub/hugh/jove-dev/"
SRC_URI="mirror://debian/pool/main/j/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/j/${PN}/${MY_DIFFP}.diff.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="unix98"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P/_/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${MY_DIFFP}.diff"
	epatch "${FILESDIR}/${P}-getline.patch"

	sed -i \
		-e "s:-ltermcap:-lncurses:" \
		-e "s:^OPTFLAGS =.*:OPTFLAGS = ${CFLAGS}:" \
		Makefile
}

src_compile() {
	tc-export CC

	if use unix98 ; then
		emake SYSDEFS="-DSYSVR4 -D_XOPEN_SOURCE=500" || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	# parallel install fails
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	keepdir /var/lib/jove/preserve
}
