# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/mathomatic/mathomatic-11.1c.ebuild,v 1.4 2004/07/27 23:43:01 malc Exp $

inherit eutils

DESCRIPTION="Mathomatic - Algebraic Manipulator"
HOMEPAGE="http://www.mathomatic.com/"
SRC_URI="http://www.panix.com/~gesslein/${P}.tgz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="icc"

DEPEND="sys-libs/readline \
	sys-libs/ncurses \
	icc? ( dev-lang/icc )"

S=${WORKDIR}/am

src_compile() {
	epatch ${FILESDIR}/gentoo-${P}.diff || die "patching failed"
	if use icc; then
		CC="icc" CFLAGS="-O3 -axKWNBP -ipo" LDFLAGS="-O3 -axKWNBP -ipo -limf" emake || die "emake failed"
	else
		LDFLAGS="-lm" emake || die "emake failed"
	fi

	make test
}

src_install() {
	PREFIX=${D} MANDIR=${D}/usr/share/man einstall || die "einstall failed"
	dohtml am.htm manual.htm notes.htm
	newdoc changes.txt CHANGES
	newdoc lgpl.txt LGPL
	newdoc readme.txt README

	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins tests/*in
}
