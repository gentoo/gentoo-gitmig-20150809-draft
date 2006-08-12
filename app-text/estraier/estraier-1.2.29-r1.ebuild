# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/estraier/estraier-1.2.29-r1.ebuild,v 1.1 2006/08/12 14:56:49 hattya Exp $

IUSE="chasen debug kakasi mecab zlib"

DESCRIPTION="a personal full-text search system"
HOMEPAGE="http://estraier.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

DEPEND=">=dev-db/qdbm-1.8.37
	|| (
		chasen? ( app-text/chasen )
		mecab?  ( app-text/mecab )
		kakasi? ( app-i18n/kakasi )
	)
	zlib? ( sys-libs/zlib )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	# fix for insecure runpath warning.
	sed -i "/^LDENV/d" Makefile.in

	# backport from Hyper Estraier
	sed -i "/mecab_destroy/s:\(^.*$\):/*\1 */:" estmecab.c

}

src_compile() {

	local myconf=

	if use chasen; then
		myconf="`use_enable chasen`"

	elif use mecab; then
		myconf="`use_enable mecab`"

	elif use kakasi; then
		myconf="`use_enable kakasi`"

	else
		myconf="--enable-cjkuni"

	fi

	econf \
		`use_enable zlib` \
		`use_enable debug` \
		--enable-dlfilter \
		--enable-regex \
		--with-sysqdbm \
		${myconf} \
		|| die
	emake || die

}

src_install() {

	emake DESTDIR="${D}" install || die
	dodoc README* ChangeLog
	dohtml *.html

	rm -f "${D}"/usr/share/${PN}/{COPYING,ChangeLog}
	rm -f "${D}"/usr/share/${PN}/*.html

}
