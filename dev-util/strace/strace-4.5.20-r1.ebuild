# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.5.20-r1.ebuild,v 1.1 2010/10/12 12:34:06 flameeyes Exp $

EAPI="2"

inherit flag-o-matic autotools

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="http://sourceforge.net/projects/strace/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="static aio alsa"

# strace only uses the header from libaio
DEPEND="aio? ( >=dev-libs/libaio-0.3.106 )
	alsa? ( media-sound/alsa-headers )
	sys-kernel/linux-headers"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-sparc.patch #336939
	epatch "${FILESDIR}"/${P}-ioctlent.patch

	# Force rebuild of the list
	rm linux/ioctlent.h || die

	eautoreconf
}

src_configure() {
	filter-lfs-flags # configure handles this sanely
	use static && append-ldflags -static

	use aio || export ac_cv_header_libaio_h=no

	# Without maintainer mode the list won't be rebuilt
	econf \
		--enable-maintainer-mode \
		|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog CREDITS NEWS PORTING README* TODO || die
}
