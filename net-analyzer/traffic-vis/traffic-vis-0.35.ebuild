# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traffic-vis/traffic-vis-0.35.ebuild,v 1.3 2003/12/09 18:12:58 lanius Exp $

DESCRIPTION="Generate traffic stats in html, ps, text and gif format"
HOMEPAGE="http://www.mindrot.org/traffic-vis.html"
SRC_URI="http://www.mindrot.org/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE="gif"
DEPEND="virtual/glibc
	>=net-libs/libpcap-0.4
	gif? ( media-libs/netpbm
		virtual/ghostscript
		dev-lang/perl )
	=dev-libs/glib-1.2*"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	make || die "make failed"
}

src_install() {
	dosbin collector/traffic-collector
	doman collector/traffic-collector.8

	for mybin in 	`use gif >/dev/null && echo "frontends/traffic-togif"` \
			frontends/traffic-tohtml \
			frontends/traffic-tops \
			frontends/traffic-totext \
			sort/traffic-sort \
			utils/traffic-exclude \
			utils/traffic-resolve ; do

		dobin ${mybin}
		doman ${mybin}.8
	done

	exeinto /etc/init.d
	newexe ${FILESDIR}/traffic-vis.init.d traffic-vis
	insinto /etc/conf.d
	newins ${FILESDIR}/traffic-vis.conf.d traffic-vis

	dodoc TODO README COPYING BUGS CHANGELOG
}
