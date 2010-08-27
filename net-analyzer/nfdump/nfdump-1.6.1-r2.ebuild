# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nfdump/nfdump-1.6.1-r2.ebuild,v 1.2 2010/08/27 06:28:31 fauli Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A set of tools to collect and process netflow data"
HOMEPAGE="http://nfdump.sourceforge.net/"
SRC_URI="mirror://sourceforge/nfdump/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 x86"
# Fails to build readpcap:
# https://sourceforge.net/tracker/?func=detail&aid=2996582&group_id=119350&atid=683752
IUSE="compat15 debug ftconv nfprofile sflow"

CDEPEND="
	ftconv? ( sys-libs/zlib net-analyzer/flow-tools )
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
	fi
	sed -i bin/Makefile.am -e '/^AM_CFLAGS/d' || die
	eautoreconf
}

src_configure() {
	# --without-ftconf is not handled well #322201
	econf \
		$(use ftconv && echo "--enable-ftconv --with-ftpath=/usr") \
		$(use nfprofile && echo "--enable-nfprofile") \
		$(use_enable sflow) \
		$(use_enable debug devel) \
		$(use_enable compat15)
	#	$(use_enable readpcap) \
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
