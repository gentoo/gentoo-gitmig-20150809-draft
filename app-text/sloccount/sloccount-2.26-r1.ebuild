# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sloccount/sloccount-2.26-r1.ebuild,v 1.2 2005/03/31 16:00:09 fmccor Exp $

inherit eutils

DESCRIPTION="Tools for counting Source Lines of Code (SLOC) for a large number of languages"
HOMEPAGE="http://www.dwheeler.com/sloccount/"
SRC_URI="http://www.dwheeler.com/sloccount/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 sparc"
IUSE=""
RDEPEND="dev-lang/perl
		>=sys-apps/sed-4
		app-shells/bash"
DEPEND="${RDEPEND}
		sys-devel/gcc"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-libexec.patch
	epatch ${FILESDIR}/${P}-coreutils-tail-n-fix.patch

	sed -i \
		-e "/^CC/ { s/$/ ${CFLAGS}/g }" \
		-e "/^DOC_DIR/ { s/-\$(RPM_VERSION)//g }" \
		-e "/^MYDOCS/ { s/[^    =]\+\.html//g }" \
		makefile || die "sed makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall PREFIX="${D}/usr" || die
	prepalldocs
	dohtml *html
}
