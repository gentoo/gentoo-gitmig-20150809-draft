# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dash/dash-0.5.6.1-r1.ebuild,v 1.4 2010/09/11 16:06:45 vapier Exp $

EAPI="2"

inherit autotools eutils flag-o-matic toolchain-funcs

DEB_PV=${PV%.*}
DEB_PATCH=${PV##*.}
DEB_PF="${PN}_${DEB_PV}.${DEB_PATCH}-1~exp0"
MY_P="${PN}-${DEB_PV}"

DESCRIPTION="DASH is a direct descendant of the NetBSD version of ash (the Almquist SHell) and is POSIX compliant"
HOMEPAGE="http://gondor.apana.org.au/~herbert/dash/"
SRC_URI="http://gondor.apana.org.au/~herbert/dash/files/${PN}-${DEB_PV}.tar.gz
	mirror://debian/pool/main/d/dash/${DEB_PF}.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="libedit static"

RDEPEND="!static? ( libedit? ( dev-libs/libedit ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	libedit? ( static? ( dev-libs/libedit[static-libs] ) )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${WORKDIR}"/${DEB_PF}.diff
	rm  */debian/diff/0006--INPUT-exit-127-if-command_file-is-given-but-doesn-t.diff \
		|| die #328929
	epatch */debian/diff/*
	epatch "${FILESDIR}"/${P}-read-ifs.patch #331535

	# Fix the invalid sort
	sed -i -e 's/LC_COLLATE=C/LC_ALL=C/g' src/mkbuiltins

	# Use pkg-config for libedit linkage
	sed -i "/LIBS/s:-ledit:\`$(tc-getPKG_CONFIG) --libs libedit $(use static && echo --static)\`:" configure.ac

	# May as well, as the debian patches force this anyway
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static
	econf \
		--bindir=/bin \
		$(use_with libedit)
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog */debian/changelog
}
