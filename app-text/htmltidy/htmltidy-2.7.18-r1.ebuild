# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmltidy/htmltidy-2.7.18-r1.ebuild,v 1.4 2003/05/29 14:46:27 agriffis Exp $ /home/cvsroot/gentoo-x86/app-text/htmltidy/htmltidy-2.7.18.ebuild, v 1.5 2002/07/25 11:07:00 cybersystem Exp $

inherit eutils

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

# convert from normalized gentoo version number to htmltidy's wacky date thing
parts=(${PV//./ })
vers=$(printf "%02d%02d%02d" ${parts[0]} ${parts[1]} ${parts[2]})
MY_P=tidy_src_${vers}
S=${WORKDIR}/tidy

DESCRIPTION="fix mistakes and tidy up sloppy editing in HTML and XML"
SRC_URI="http://tidy.sourceforge.net/src/old/${MY_P}.tgz"
HOMEPAGE="http://tidy.sourceforge.net/"
DEPEND=""
IUSE="xml"

src_unpack() {
	unpack ${MY_P}.tgz
	cd ${S}
	use xml && epatch ${FILESDIR}/htmltidy-dbpatch.diff

	# skip "chown"
	t=Makefile
	cp $t $t.orig
	sed 's:chgrp\|chown:#&:' $t.orig > $t
}

src_compile() {
	emake \
		OTHERCFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	make \
		INSTALLDIR="${D}/usr/" \
		MANPAGESDIR="${D}/usr/share/man" \
		install || die
}
