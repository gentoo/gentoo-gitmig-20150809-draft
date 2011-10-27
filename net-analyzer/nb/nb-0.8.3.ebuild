# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nb/nb-0.8.3.ebuild,v 1.2 2011/10/27 18:42:06 jer Exp $

EAPI="3"

inherit autotools-utils

DESCRIPTION="Nodebrain is a tool to monitor and do event correlation."
HOMEPAGE="http://nodebrain.sourceforge.net/"
SRC_URI="mirror://sourceforge/nodebrain/nodebrain-${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="static-libs"

DEPEND="dev-lang/perl"
RDEPEND="
	!sys-boot/netboot
	!www-apps/nanoblogger
"

S="${WORKDIR}/nodebrain-${PV}"

src_prepare() {
	# Prevent make from rebuilding this target, since
	# fdl.texi is not included in the distribution
	touch doc/nbTutorial/nbTutorial.info || die
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	# Fails at parallel make
	emake -j1 || die
}

src_install() {
	#DIR="${D}/usr" ./install-nb || die "install failed"
	emake DESTDIR="${D}" install || die
	use static-libs || remove_libtool_files
	dodoc AUTHORS NEWS README THANKS sample/*
	dohtml html/*
}
