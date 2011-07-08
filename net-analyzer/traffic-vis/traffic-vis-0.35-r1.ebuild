# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traffic-vis/traffic-vis-0.35-r1.ebuild,v 1.6 2011/07/08 11:09:11 ssuominen Exp $

inherit eutils

DESCRIPTION="Generate traffic stats in html, ps, text and gif format"
HOMEPAGE="http://www.mindrot.org/traffic-vis.html"
SRC_URI="http://www.mindrot.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE="gif"
DEPEND="net-libs/libpcap
	gif? ( media-libs/netpbm
		app-text/ghostscript-gpl
		dev-lang/perl )
	=dev-libs/glib-1.2*"

src_unpack() {
	unpack ${A} ; cd "${S}"

	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-libpcap-header-fix.patch
	# bug 143930 - traffic-vis expects /usr/sbin/traffic-tops
	sed -i -e "s:/usr/sbin/traffic-tops:/usr/bin/traffic-tops:g" \
		"${S}"/frontends/traffic-togif
}

src_compile() {
	make || die "make failed"
}

src_install() {
	dosbin collector/traffic-collector
	doman collector/traffic-collector.8

	for mybin in $(use gif && echo frontends/traffic-togif) \
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
