# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-1.2.7-r2.ebuild,v 1.1 2011/10/27 22:07:56 blueness Exp $

EAPI=4

MY_P="${PN}-core-${PV}"

DESCRIPTION="Xapian Probabilistic Information Retrieval library"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://oligarchy.co.uk/xapian/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs -sse +sse2 -nosse +brass +chert +flint +inmemory +remote"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	local count=0
	use nosse && count=$((count+1))
	use sse && count=$((count+1))
	use sse2 && count=$((count+1))

	local myconf=""

	if [ $count != 1 ] ; then
		ewarn "\033[1;33m************************************************************\033[m"
		ewarn "One and only one of 'nosse' or 'sse' or 'sse2' should be"
		ewarn "enabled in your USE flags.  Note that sse2 is enabled by"
		ewarn "default.  If you enable one then disable two using -flag."
		ewarn
		use nosse && ewarn "\tnosse\t\tenabled" || ewarn "\tnosse\t\tdisabled"
		use sse && ewarn "\tsse\t\tenabled" || ewarn "\tsse\t\tdisabled"
		use sse2 && ewarn "\tsse2\t\tenabled" || ewarn "\tsse2\t\tdisabled"
		ewarn
		ewarn "I'm assuming you meant USE='-nosse -sse sse2' ... I hope I'm right!"
		ewarn "\033[1;33m************************************************************\033[m"

		myconf="${myconf} --enable-sse=sse2"

	else
		use nosse && myconf="${myconf} --disable-sse"
		use sse && myconf="${myconf} --enable-sse=sse"
		use sse2 && myconf="${myconf} --enable-sse=sse2"
	fi

	myconf="${myconf} $(use_enable static-libs static)"

	use brass || myconf="${myconf} --disable-backend-brass"
	use chert || myconf="${myconf} --disable-backend-chert"
	use flint || myconf="${myconf} --disable-backend-flint"
	use inmemory || myconf="${myconf} --disable-backend-inmemory"
	use remote || myconf="${myconf} --disable-backend-remote"

	econf $myconf
}

src_install() {
	emake DESTDIR="${D}" install

	mv "${D}usr/share/doc/xapian-core" "${D}usr/share/doc/${PF}"
	use doc || rm -fr "${D}usr/share/doc/${PF}"

	dodoc AUTHORS HACKING PLATFORMS README NEWS
}

src_test() {
	emake check VALGRIND=
}
