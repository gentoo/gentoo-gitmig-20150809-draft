# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/phrack/phrack-62.ebuild,v 1.1 2004/07/14 01:48:19 vapier Exp $

MY_P=${PN}${PV}
DESCRIPTION="...a Hacker magazine by the community, for the community...."
HOMEPAGE="http://www.phrack.org/"
SRC_URI="http://www.phrack.org/archives/${MY_P}.tar.gz"

LICENSE="phrack"
SLOT="${PV}"
KEYWORDS="x86 ppc"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	[ -d ${S} ] || cd ${WORKDIR}/*
	insinto /usr/share/doc/${PN}
	gzip *
	doins * || die
}
