# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/minicom/minicom-2.1-r2.ebuild,v 1.4 2006/03/13 15:01:27 gustavoz Exp $

inherit eutils flag-o-matic

DESCRIPTION="Serial Communication Program"
HOMEPAGE="http://alioth.debian.org/projects/minicom"
SRC_URI="http://alioth.debian.org/download.php/123/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2-r3"
RDEPEND="${DEPEND}
	net-dialup/lrzsz"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# solar@gentoo.org (Mar 24 2004)
	# propolice/ssp caught minicom going out of bounds here.
	epatch "${FILESDIR}"/${P}-memcpy-bounds.diff
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-gentoo-runscript.patch
}

src_compile() {
	# avoid lazy binding (minicom is sgided)
	append-ldflags $(bindnow-flags)

	econf --sysconfdir=/etc/${PN} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	#minicom must be uucp sgided is needed for being able to lock serial ports
	#when run as simple user
	fowners root:uucp /usr/bin/minicom
	fperms g+s /usr/bin/minicom

	dodoc doc/minicom.FAQ
	insinto /etc/minicom
	doins "${FILESDIR}"/minirc.dfl

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_preinst() {
	[[ -s /etc/minicom/minirc.dfl ]] \
		&& rm -f "${IMAGE}"/etc/minicom/minirc.dfl
}
