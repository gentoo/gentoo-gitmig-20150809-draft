# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dash/dash-0.4.26.ebuild,v 1.4 2004/08/20 23:04:50 seemant Exp $

MY_P="${P/-/_}"
DESCRIPTION="Debian-version of NetBSD's lightweight bourne shell"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/d/dash/"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/dash/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="sys-devel/pmake
	sys-apps/sed
	dev-util/yacc"

S=${WORKDIR}/${PN}

src_compile() {
	# pmake name conflicts, use full path
	/usr/bin/pmake CFLAGS:="-Wall -DBSD=1 -DSMALL -D_GNU_SOURCE -DGL \
		-DIFS_BROKEN -D__COPYRIGHT\(x\)= -D__RCSID\(x\)= \
		-D_DIAGASSERT\(x\)= -g -O2 -fstrict-aliasing" YACC:=bison || die
}

src_install() {
	exeinto /bin
	newexe sh dash

	newman sh.1 dash.1
	#dosym /usr/share/man/man1/ash.1.gz /usr/share/man/man1/sh.1.gz

	dodoc TOUR debian/changelog
}
