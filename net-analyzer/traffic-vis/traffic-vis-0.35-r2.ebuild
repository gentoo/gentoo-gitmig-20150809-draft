# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traffic-vis/traffic-vis-0.35-r2.ebuild,v 1.2 2010/09/10 07:46:04 mr_bones_ Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Generate traffic stats in html, ps, text and gif format"
HOMEPAGE="http://www.mindrot.org/traffic-vis.html"
SRC_URI="http://www.mindrot.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="gif"
DEPEND="net-libs/libpcap
	gif? ( media-libs/netpbm
		app-text/ghostscript-gpl
		dev-lang/perl )
	=dev-libs/glib-1.2*"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-libpcap-header-fix.patch

	# bug 143930 - traffic-vis expects /usr/sbin/traffic-tops
	sed -i frontends/traffic-togif \
		-e "s:/usr/sbin/traffic-tops:/usr/bin/traffic-tops:g" \
		|| die "sed frontends/traffic-togif"

	tc-export CC
}

src_install() {
	dosbin collector/traffic-collector
	doman collector/traffic-collector.8

	for mybin in $(useq gif && echo frontends/traffic-togif) \
			frontends/traffic-tohtml \
			frontends/traffic-tops \
			frontends/traffic-totext \
			sort/traffic-sort \
			utils/traffic-exclude \
			utils/traffic-resolve ; do

		dobin ${mybin}
		doman ${mybin}.8
	done

	newinitd "${FILESDIR}"/traffic-vis.init.d traffic-vis
	newconfd "${FILESDIR}"/traffic-vis.conf.d traffic-vis

	dodoc TODO README BUGS CHANGELOG
}
