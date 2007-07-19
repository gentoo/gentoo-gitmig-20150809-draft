# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/phrack/phrack-55.ebuild,v 1.11 2007/07/19 19:13:16 vapier Exp $

MY_P=${PN}${PV}
DESCRIPTION="...a Hacker magazine by the community, for the community...."
HOMEPAGE="http://www.phrack.org/"
SRC_URI="http://www.phrack.org/archives/${MY_P}.tar.gz"

LICENSE="phrack"
SLOT="${PV}"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	[[ -d ${S} ]] || cd "${WORKDIR}"/*
	insinto /usr/share/doc/${PN}
	doins * || die "doins failed"
	prepalldocs
}
