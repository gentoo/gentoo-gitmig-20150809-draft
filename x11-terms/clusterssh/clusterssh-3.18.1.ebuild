# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/clusterssh/clusterssh-3.18.1.ebuild,v 1.1 2006/07/20 05:20:10 dberkholz Exp $

DESCRIPTION="Concurrent Multi-Server Terminal Access."
HOMEPAGE="http://clusterssh.sourceforge.net"
SRC_URI="mirror://sourceforge/clusterssh/clusterssh-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-perl/perl-tk
	dev-perl/Config-Simple
	dev-perl/X11-Protocol"

src_compile() {
	# Gentoo perl ebuilds remove podchecker
	if grep -v podchecker "${S}"/src/Makefile.in \
		> "${S}"/src/Makefile.in.new; then
		mv "${S}"/src/Makefile.in.new "${S}"/src/Makefile.in
	else
		die "Makefile.in update failed"
	fi

	econf || die "configuration failed"
	emake || die "compiling failed"
}

src_install() {
	cd "${S}"
	dodoc AUTHORS COPYING INSTALL NEWS README THANKS
	dobin src/cssh
	doman src/cssh.1
}

pkg_postinst() {
	elog "IMPORTANT:"
	elog "If you use a term program other than xterm, you will most likely see
	'-xrm' errors."
	elog "To fix, do the following:"
	elog "	echo terminal_allow_send_events= >> ~/.csshrc"
}
