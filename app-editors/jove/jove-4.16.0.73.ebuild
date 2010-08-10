# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jove/jove-4.16.0.73.ebuild,v 1.1 2010/08/10 13:11:07 ulm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Jonathan's Own Version of Emacs - a light emacs-like editor without LISP bindings"
HOMEPAGE="ftp://ftp.cs.toronto.edu/cs/ftp/pub/hugh/jove-dev/"
SRC_URI="ftp://ftp.cs.toronto.edu/cs/ftp/pub/hugh/jove-dev/${PN}${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc unix98"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-4.16.0.70.3.1-getline.patch"
	epatch "${FILESDIR}/${P}-build.patch"
	epatch "${FILESDIR}/${P}-sendmail.patch"
	epatch "${FILESDIR}/${P}-doc.patch"
}

src_compile() {
	tc-export CC

	if use unix98; then
		emake OPTFLAGS="${CFLAGS}" SYSDEFS="-DSYSVR4 -D_XOPEN_SOURCE=500" \
			|| die
	else
		emake OPTFLAGS="${CFLAGS}" || die
	fi

	if use doc; then
		# Full manual (*not* man page)
		emake doc/jove.man || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	keepdir /var/lib/jove/preserve

	dodoc README
	if use doc; then
		dodoc doc/jove.man || die
	fi
}
