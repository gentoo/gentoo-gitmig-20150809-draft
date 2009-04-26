# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcwipe/bcwipe-1.7_p7.ebuild,v 1.4 2009/04/26 19:16:16 ranger Exp $

inherit toolchain-funcs eutils

MY_PV="${PV/_p/-}"

DESCRIPTION="BCWipe secure file removal utility"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BCWipe-${MY_PV}.tar.gz
	doc? ( http://www.jetico.com/linux/BCWipe.doc.tgz )"

LICENSE="bestcrypt"
SLOT="0"
IUSE="doc"
KEYWORDS="amd64 ppc sparc x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-build.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "Make failed"
}

src_test() {
	echo "abc123" >> testfile
	./bcwipe -f testfile || die "bcwipe test failed"
	[ -f testfile ] && die "test file still exists. bcwipe should of deleted it"
}

src_install() {
	dobin bcwipe || die "dobin bcwipe failed"
	doman bcwipe.1 || die "doman bcwipe.1 failed"
	if use doc ; then
		dohtml -r ../bcwipe-help || die "dohtml failed"
	fi
}

pkg_postinst() {
	ewarn "The BestCrypt drivers are not free - Please purchace a license from "
	ewarn "http://www.jetico.com/"
	ewarn "full details /usr/share/doc/${PF}/html/bcwipe-help/wu_licen.htm"
}
