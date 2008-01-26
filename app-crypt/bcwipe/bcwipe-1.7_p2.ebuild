# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcwipe/bcwipe-1.7_p2.ebuild,v 1.1 2008/01/26 12:30:25 alonbl Exp $

inherit toolchain-funcs eutils

MY_PV="${PV/_p/-}"

DESCRIPTION="BCWipe secure file removal utility"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BCWipe-${MY_PV}.tar.gz
	http://www.jetico.com/linux/BCWipe.doc.tgz"

LICENSE="bestcrypt"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	emake CC="$(tc-getCC)" DEFS="${CFLAGS}"|| die "Make failed"
}

src_test() {
	echo "abc123" >> testfile
	./bcwipe -f testfile || die "bcwipe test failed"
	[ -f testfile ] && die "test file still exists. bcwipe should of deleted it"
}

src_install() {
	dobin bcwipe
	doman bcwipe.1
	use doc && dohtml -r ../bcwipe-help
}

pkg_postinst() {
	ewarn "The BestCrypt drivers are not free - Please purchace a license from "
	ewarn "http://www.jetico.com/"
	ewarn "full details /usr/share/doc/${PF}/wu_licen.htm"
}
