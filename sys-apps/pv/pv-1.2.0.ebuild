# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pv/pv-1.2.0.ebuild,v 1.8 2011/03/11 17:22:17 tomka Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="http://pipeviewer.googlecode.com/files/${P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc64-solaris ~x86-solaris"
IUSE="nls"

src_configure() {
	econf $(use_enable nls)
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getLD)" \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc README doc/NEWS doc/TODO || die
}
