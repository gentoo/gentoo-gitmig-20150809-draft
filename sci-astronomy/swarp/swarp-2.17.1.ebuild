# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/swarp/swarp-2.17.1.ebuild,v 1.1 2009/02/17 20:54:23 bicatali Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Resample and coadd astronomical FITS images"
HOMEPAGE="http://terapix.iap.fr/soft/swarp"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc threads mpi"
RDEPEND="mpi? ( virtual/mpi )"
DEPEND="${RDEPEND}"

src_configure() {
	use mpi || export MPICC="$(tc-getCC)"
	local myconf
	# --disable-threads is buggy
	use threads && myconf="--enable-threads"
	econf \
		$(use_enable mpi) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog HISTORY README THANKS BUGS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/* || die
	fi
}
