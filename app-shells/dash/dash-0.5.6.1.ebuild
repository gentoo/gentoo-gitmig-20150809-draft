# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dash/dash-0.5.6.1.ebuild,v 1.1 2010/07/18 22:08:31 vapier Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

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

DEPEND="libedit? ( dev-libs/libedit )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${WORKDIR}"/${DEB_PF}.diff
	epatch */debian/diff/*

	# Fix the invalid sort
	sed -i -e 's/LC_COLLATE=C/LC_ALL=C/g' src/mkbuiltins

	# Always statically link libedit in to ensure we always boot if it changes
	# which it has done in the past.
	local s="s/-ledit/-Wl,-Bstatic -ledit -Wl,-Bdynamic -lcurses/g"
	use static && s="s/-ledit/-ledit -lcurses/g"
	sed -i -e "${s}" configure.ac || die "Failed to sed configure.ac"

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
