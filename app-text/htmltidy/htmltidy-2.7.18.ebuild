# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/htmltidy/htmltidy-2.7.18.ebuild,v 1.2 2002/08/14 11:56:34 pvdabeel Exp $ /home/cvsroot/gentoo-x86/app-text/htmltidy/htmltidy-2.7.18.ebuild, v 1.5 2002/07/25 11:07:00 cybersystem Exp $

# convert from normalized gentoo version number to htmltidy's wacky date thing

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

parts=(${PV//./ })
vers=$(printf "%02d%02d%02d" ${parts[0]} ${parts[1]} ${parts[2]})
MY_P=tidy_src_${vers}
S=${WORKDIR}/tidy

DESCRIPTION="fix mistakes and tidy up sloppy editing in HTML and XML"
SRC_URI="http://tidy.sourceforge.net/src/${MY_P}.tgz"
HOMEPAGE="http://tidy.sourceforge.net/"
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

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

src_install () {
	mkdir -p "${D}/usr/bin"
	mkdir -p "${D}/usr/share/man/man1"
	make \
		INSTALLDIR="${D}/usr/" \
		MANPAGESDIR="${D}/usr/share/man" \
		install || die
}
