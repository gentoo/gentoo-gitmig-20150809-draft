# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-wrapper/autoconf-wrapper-1.ebuild,v 1.1 2004/10/21 01:06:11 vapier Exp $

DESCRIPTION="wrapper for autoconf to manage multiple autoconf versions"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"

S=${WORKDIR}

src_install() {
	exeinto /usr/lib/misc
	newexe ${FILESDIR}/ac-wrapper-${PV}.pl ac-wrapper.pl

	dodir /usr/bin
	local x=
	for x in auto{conf,header,m4te,reconf,scan,update} ifnames ; do
		dosym ../lib/misc/ac-wrapper.pl /usr/bin/${x}
	done
}
