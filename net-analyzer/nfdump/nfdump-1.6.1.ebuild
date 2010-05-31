# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nfdump/nfdump-1.6.1.ebuild,v 1.2 2010/05/31 20:50:13 jer Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A set of tools to collect and process netflow data"
HOMEPAGE="http://nfdump.sourceforge.net/"
SRC_URI="mirror://sourceforge/nfdump/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Fails to build readpcap:
# https://sourceforge.net/tracker/?func=detail&aid=2996582&group_id=119350&atid=683752
IUSE="ftconv nfprofile sflow"

CDEPEND="
	ftconv? ( sys-libs/zlib
		net-analyzer/flow-tools )
	nfprofile? ( net-analyzer/rrdtool )"
#	readpcap? ( net-libs/libpcap )"
DEPEND="${CDEPEND}
	sys-devel/flex"
RDEPEND=${CDEPEND}"
	dev-lang/perl"

src_prepare() {
	if use ftconv; then
		sed '/ftbuild.h/d' -i bin/ft2nfdump.c || die
		sed 's:lib\(/ftlib.h\):include\1:' -i configure.in || die
		eautoreconf
	fi
}

src_configure() {
	# When USE=ftconv, after we run eautoreconf, we need to define the switches
	# differently (bug #322201)
	local myconf
	if use ftconv; then
		myconf="--with-ftpath=/usr --enable-ftconv"
	else
		myconf="--without-ftconv"
	fi

	econf \
		${myconf} \
		$(use_enable nfprofile) \
		$(use_enable sflow)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
