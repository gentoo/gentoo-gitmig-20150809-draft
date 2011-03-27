# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcwipe/bcwipe-1.9.8.ebuild,v 1.3 2011/03/27 19:08:23 ranger Exp $

EAPI="3"

inherit eutils versionator

MY_PV="$(replace_version_separator 2 -)"

DESCRIPTION="Secure file removal utility"
HOMEPAGE="http://www.jetico.com/"
SRC_URI="http://www.jetico.com/linux/BCWipe-${MY_PV}.tar.gz
	doc? ( http://www.jetico.com/linux/BCWipe.doc.tgz )"

LICENSE="bestcrypt"
SLOT="0"
IUSE="doc"
KEYWORDS="amd64 ppc ~sparc ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.9.7-fix_warnings.patch \
			"${FILESDIR}"/${P}-fix-flags.patch
}

src_test() {
	echo "abc123" >> testfile
	./bcwipe -f testfile || die "bcwipe test failed"
	[[ -f testfile ]] && die "test file still exists. bcwipe should have deleted it"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc ; then
		dohtml -r ../bcwipe-help || die "dohtml failed"
	fi
}

pkg_postinst() {
	ewarn "The BestCrypt drivers are not free - Please purchace a license from "
	ewarn "http://www.jetico.com/"
	ewarn "full details /usr/share/doc/${PF}/html/bcwipe-help/wu_licen.htm"
}
