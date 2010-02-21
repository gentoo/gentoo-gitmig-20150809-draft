# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aegis/aegis-4.24.ebuild,v 1.4 2010/02/21 01:07:59 abcd Exp $

EAPI=3

inherit autotools

DESCRIPTION="A transaction based revision control system"
SRC_URI="mirror://sourceforge/aegis/${P}.tar.gz"
HOMEPAGE="http://aegis.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~sparc ~x86 ~x86-linux ~ppc-macos"
IUSE="tk"

DEPEND="sys-libs/zlib
	sys-devel/gettext
	sys-apps/groff
	sys-devel/bison
	dev-libs/libxml2
	tk? ( >=dev-lang/tk-8.3 )"
RDEPEND="" #221421

src_prepare() {
	#FIXME: ? Not sure what effect this has. Only way to get it to compile.
	sed -i 's/$(SH) etc\/compat.2.3//' Makefile.in || \
		die "sed Makefile.in failed"
	eautomake || die "eautomake failed"
}

src_configure() {
	# By default aegis configure puts shareable read/write files (locks etc)
	# in ${prefix}/com/aegis but the FHS says /var/lib/aegis can be shared.

	econf \
		--sharedstatedir=/var/lib/aegis \
		--with-nlsdir=/usr/share/locale
}

src_compile() {
	# bug #297334
	emake -j1 || die
}

src_install () {
	emake -j1 RPM_BUILD_ROOT="${D}" install || die

	# OK so ${D}/var/lib/aegis gets UID=3, but for some
	# reason so do the files under /usr/share, even though
	# they are read-only.
	use prefix || fowners -R root:root /usr/share
	dodoc lib/en/*

	# Link to share dir so user has a chance of noticing it.
	dosym /usr/share/aegis /usr/share/doc/${PF}/scripts

	# Config file examples are documentation.
	mv "${ED}"/usr/share/aegis/config.example "${ED}"/usr/share/doc/${PF}/

	dodoc BUILDING README
}
