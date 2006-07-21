# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xtraceroute/xtraceroute-0.9.1-r1.ebuild,v 1.3 2006/07/21 05:58:48 tsunam Exp $

DESCRIPTION="neat graphical traceroute displaying route on the globe"
SRC_URI="http://www.dtek.chalmers.se/~d3august/xt/dl/${P}.tar.gz
	http://www.dtek.chalmers.se/~d3august/xt/dl/ndg_files.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/~d3august/xt/"

KEYWORDS="~amd64 ~ppc sparc x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="nls"

DEPEND="|| (
	( >=media-libs/mesa-6.4.1-r1
	>=x11-libs/libX11-1.0.0
	>=x11-libs/libXext-1.0.0
	>=x11-libs/libXi-1.0.0 )
	virtual/x11 )
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	net-analyzer/traceroute
	<x11-libs/gtkglarea-1.99.0
	media-libs/gdk-pixbuf
	net-dns/host"

src_compile() {

	# Fix 'head' problem, Bug #63019 (21 Nov 2004 eldad)
	sed -i -e 's/head -1/head -n 1/' share/xtraceroute-resolve-location.sh.in

	# specify --from-code to fix bug 25395 (01 Aug 2003 agriffis)
	XGETTEXT='/usr/bin/xgettext --from-code=ISO-8859-1' \
	./configure \
		`use_enable nls` \
		--host=${CHOST} \
		--prefix=/usr \
		--with-host=/usr/bin/hostx \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man

	if [ $? != 0 ]; then
		echo
		eerror "If configure fails with 'Cannot find proper gtkgl version'"
		eerror "try to 'eselect opengl' and then re-emerge =gtkglarea-1.2.3*."
		eerror "# eselect opengl set <GL implementation>"
		eerror "# emerge =gtkglarea-1.2.3*"
		echo
		die "configure failed."
	fi

	emake || die "emake failed"
}

src_install () {
	make \
		prefix="${D}"/usr \
		mandir="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		install || die "make install failed"

	# Install documentation.
	dodoc AUTHORS NEWS README TODO || die "dodoc failed"

	#Install NDG loc database
	cd "${D}"/usr/share/xtraceroute/
	unpack "ndg_files.tar.gz"
}
